## **Docs, Info, etc:** https://developer.valvesoftware.com/wiki/Steam_Web_API
import asyncdispatch, httpclient, strutils, json

const
  steamApiUrl* =
    when defined(ssl): "https://api.steampowered.com/" ## Steam API URL (SSL).
    else:              "http://api.steampowered.com/"  ## Steam API URL (No SSL).
  a = steamApiUrl & "SteamNews/GetNewsForApp/v0002/?format=json&appid="
  b = steamApiUrl & "ISteamUserStats/GetGlobalAchievementPercentagesForApp/v0002/?format=json&gameid="
  c = steamApiUrl & "ISteamUserStats/GetGlobalStatsForGame/v0001/?format=json&appid="
  d = steamApiUrl & "ISteamUser/GetPlayerSummaries/v0002/?format=json&steamids="
  e = steamApiUrl & "ISteamUser/GetFriendList/v0001/?format=json&steamid="
  f = steamApiUrl & "ISteamUserStats/GetPlayerAchievements/v0001/?format=json&appid="
  g = steamApiUrl & "ISteamUserStats/GetUserStatsForGame/v0002/?format=json&appid="
  h = steamApiUrl & "/IPlayerService/GetOwnedGames/v0001/?format=json&include_appinfo=true&steamid="
  i = steamApiUrl & "PlayerService/GetRecentlyPlayedGames/v0001/?format=json&steamid="
  j = steamApiUrl & "IPlayerService/IsPlayingSharedGame/v0001/?format=json&steamid="
  k = steamApiUrl & "ISteamUserStats/GetSchemaForGame/v2/?format=json&appid="
  l = steamApiUrl & "ISteamUserStats/GetSchemaForGame/v2/?format=json&steamids="

type
  SteamBase*[HttpType] = object ## Base object.
    timeout*: byte  ## Timeout Seconds for API Calls, byte type, 1~255.
    proxy*: Proxy  ## Network IPv4 / IPv6 Proxy support, Proxy type.
  Steam* = SteamBase[HttpClient]           ##  Sync Steam API Client.
  AsyncSteam* = SteamBase[AsyncHttpClient] ## Async Steam API Client.

using
  steamids: seq[int]
  count, maxlength: byte
  name, key, relationship: string
  appid, appid_playing, steamid: int

template clientify(this: Steam | AsyncSteam): untyped =
  ## Build & inject basic HTTP Client with Proxy and Timeout.
  var client {.inject.} =
    when this is AsyncSteam: newAsyncHttpClient(
      proxy = when declared(this.proxy): this.proxy else: nil, userAgent="")
    else: newHttpClient(
      timeout = when declared(this.timeout): this.timeout.int * 1_000 else: -1,
      proxy = when declared(this.proxy): this.proxy else: nil, userAgent="")
  client.headers = newHttpHeaders({"dnt": "1", "accept":
    "application/json", "content-type": "application/json"})

proc getNewsForApp*(this: Steam | AsyncSteam, appid, count, maxlength): Future[JsonNode] {.multisync.} =
  ## GetNewsForApp returns the latest of a game specified by its appID.
  clientify(this)
  let url = a & $appid & "&count=" & $count & "&maxlength=" & $maxlength
  result =
    when this is AsyncSteam: parse_json(await client.getContent(url=url))
    else: parse_json(client.getContent(url=url))

proc getGlobalAchievementPercentagesForApp*(this: Steam | AsyncSteam, appid): Future[JsonNode] {.multisync.} =
  ## Returns on global achievements overview of a specific game in percentages.
  clientify(this)
  let url = b & $appid
  result =
    when this is AsyncSteam: parse_json(await client.getContent(url=url))
    else: parse_json(client.getContent(url=url))

proc getGlobalStatsForGame*(this: Steam | AsyncSteam, appid, count, maxlength, name): Future[JsonNode] {.multisync.} =
  ## Returns on global stats overview of a specific game in percentages.
  clientify(this)
  let url = c & $appid & "&count=" & $count & "&name%5B0%5D=" & $name
  result =
    when this is AsyncSteam: parse_json(await client.getContent(url=url))
    else: parse_json(client.getContent(url=url))

proc getPlayerSummaries*(this: Steam | AsyncSteam, key, steamids): Future[JsonNode] {.multisync.} =
  ## Returns basic profile information for a list of 64-bit Steam IDs. Key required.
  doAssert steamids.len < 99, "steamids lenght must be less than 100 Steam IDs."
  clientify(this)
  let url = d & steamids.join(",") & "&key=" & $key
  result =
    when this is AsyncSteam: parse_json(await client.getContent(url=url))
    else: parse_json(client.getContent(url=url))

proc getFriendList*(this: Steam | AsyncSteam, key, relationship, steamid): Future[JsonNode] {.multisync.} =
  ## Returns the friend list of any Steam user, provided their Steam Community profile visibility is set to "Public". Key required.
  doAssert relationship in ["friend", "all"], "relationship must be friend or all"
  clientify(this)
  let url = e & $steamid & "&relationship=" & $relationship & "&key=" & $key
  result =
    when this is AsyncSteam: parse_json(await client.getContent(url=url))
    else: parse_json(client.getContent(url=url))

proc getPlayerAchievements*(this: Steam | AsyncSteam, key, steamid, appid): Future[JsonNode] {.multisync.} =
  ## Returns a list of achievements for this user by app id. Key required.
  clientify(this)
  let url = f & $appid & "&steamid=" & $steamid & "&key=" & $key
  result =
    when this is AsyncSteam: parse_json(await client.getContent(url=url))
    else: parse_json(client.getContent(url=url))

proc getUserStatsForGame*(this: Steam | AsyncSteam, key, steamid, appid): Future[JsonNode] {.multisync.} =
  ## Returns a list of achievements for this user by app id. Key required.
  clientify(this)
  let url = g & $appid & "&steamid=" & $steamid & "&key=" & $key
  result =
    when this is AsyncSteam: parse_json(await client.getContent(url=url))
    else: parse_json(client.getContent(url=url))

proc getOwnedGames*(this: Steam | AsyncSteam, key, steamid): Future[JsonNode] {.multisync.} =
  ## GetOwnedGames returns a list of games a player owns along with some playtime information, if the profile is publicly visible.
  ## Private, friends-only, and other privacy settings are not supported unless you are asking for your own personal details. Key required.
  clientify(this)
  let url = h & $steamid & "&key=" & $key
  result =
    when this is AsyncSteam: parse_json(await client.getContent(url=url))
    else: parse_json(client.getContent(url=url))

proc getRecentlyPlayedGames*(this: Steam | AsyncSteam, key, steamid, count): Future[JsonNode] {.multisync.} =
  ## GetRecentlyPlayedGames returns a list of games a player has played in the last two weeks, if the profile is publicly visible.
  ## Private, friends-only, and other privacy settings are not supported unless you are asking for your own personal details. Key required.
  clientify(this)
  let url = i & $steamid & "&count=" & $count & "&key=" & $key
  result =
    when this is AsyncSteam: parse_json(await client.getContent(url=url))
    else: parse_json(client.getContent(url=url))

proc isPlayingSharedGame*(this: Steam | AsyncSteam, key, steamid, appid_playing): Future[JsonNode] {.multisync.} =
  ## Return original owners SteamID if borrowing account is currently playing this game.
  ## If game is not borrowed or borrower currently doesnt play this game, result is always 0. Key required.
  clientify(this)
  let url = j & $steamid & "&key=" & $key & "&appid_playing=" & $appid_playing
  result =
    when this is AsyncSteam: parse_json(await client.getContent(url=url))
    else: parse_json(client.getContent(url=url))

proc getSchemaForGame*(this: Steam | AsyncSteam, key, appid): Future[JsonNode] {.multisync.} =
  ## Return gamename, gameversion, availablegamestats (achievements, stats). Key required.
  clientify(this)
  let url = k & $appid & "&key=" & $key
  result =
    when this is AsyncSteam: parse_json(await client.getContent(url=url))
    else: parse_json(client.getContent(url=url))

proc getPlayerBans*(this: Steam | AsyncSteam, key, steamids): Future[JsonNode] {.multisync.} =
  ## Return Community, VAC, Economy Bans statuses for given players. Key required.
  doAssert steamids.len < 99, "steamids lenght must be less than 100 Steam IDs."
  clientify(this)
  let url = l & $steamids & "&key=" & $key
  result =
    when this is AsyncSteam: parse_json(await client.getContent(url=url))
    else: parse_json(client.getContent(url=url))
