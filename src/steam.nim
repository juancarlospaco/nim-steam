import asyncdispatch, httpclient, uri, strutils, options
## :Generator: https://github.com/levshx/nim-steam/
## :Date: 2022-05-13T00:06:04Z
const
  WEBAPI_BASE_URL* =
    when defined(ssl): "https://api.steampowered.com/" ## Steam API URL (SSL).
    else:              "http://api.steampowered.com/"  ## Steam API URL (No SSL).
converter toOption*[T](x:T):Option[T] = some(x)
type
  Rawbinary* = string
  Message* = string
  Param = object
    name: string
    value: string
  SteamWebAPI* = object
    ## Sync steam WebAPI client
    IClientStats_1046930*:IClientStats_1046930
    ICSGOPlayers_730*:ICSGOPlayers_730
    ICSGOServers_730*:ICSGOServers_730
    ICSGOTournaments_730*:ICSGOTournaments_730
    IDOTA2Fantasy_205790*:IDOTA2Fantasy_205790
    IDOTA2MatchStats_205790*:IDOTA2MatchStats_205790
    IDOTA2MatchStats_570*:IDOTA2MatchStats_570
    IDOTA2Match_205790*:IDOTA2Match_205790
    IDOTA2Match_570*:IDOTA2Match_570
    IDOTA2StreamSystem_205790*:IDOTA2StreamSystem_205790
    IDOTA2StreamSystem_570*:IDOTA2StreamSystem_570
    IDOTA2Ticket_205790*:IDOTA2Ticket_205790
    IDOTA2Ticket_570*:IDOTA2Ticket_570
    IEconDOTA2_205790*:IEconDOTA2_205790
    IEconDOTA2_570*:IEconDOTA2_570
    IEconItems_1046930*:IEconItems_1046930
    IEconItems_1269260*:IEconItems_1269260
    IEconItems_205790*:IEconItems_205790
    IEconItems_221540*:IEconItems_221540
    IEconItems_238460*:IEconItems_238460
    IEconItems_440*:IEconItems_440
    IEconItems_570*:IEconItems_570
    IEconItems_583950*:IEconItems_583950
    IEconItems_620*:IEconItems_620
    IEconItems_730*:IEconItems_730
    IGCVersion_1046930*:IGCVersion_1046930
    IGCVersion_1269260*:IGCVersion_1269260
    IGCVersion_205790*:IGCVersion_205790
    IGCVersion_440*:IGCVersion_440
    IGCVersion_570*:IGCVersion_570
    IGCVersion_583950*:IGCVersion_583950
    IGCVersion_730*:IGCVersion_730
    IPortal2Leaderboards_620*:IPortal2Leaderboards_620
    ISteamApps*:ISteamApps
    ISteamBroadcast*:ISteamBroadcast
    ISteamCDN*:ISteamCDN
    ISteamDirectory*:ISteamDirectory
    ISteamEconomy*:ISteamEconomy
    ISteamNews*:ISteamNews
    ISteamRemoteStorage*:ISteamRemoteStorage
    ISteamUser*:ISteamUser
    ISteamUserAuth*:ISteamUserAuth
    ISteamUserOAuth*:ISteamUserOAuth
    ISteamUserStats*:ISteamUserStats
    ISteamWebAPIUtil*:ISteamWebAPIUtil
    ISteamWebUserPresenceOAuth*:ISteamWebUserPresenceOAuth
    ITFItems_440*:ITFItems_440
    ITFPromos_205790*:ITFPromos_205790
    ITFPromos_440*:ITFPromos_440
    ITFPromos_620*:ITFPromos_620
    ITFSystem_440*:ITFSystem_440
    IGameServersService*:IGameServersService
    IPlayerService*:IPlayerService
    IBroadcastService*:IBroadcastService
    IContentServerConfigService*:IContentServerConfigService
    IContentServerDirectoryService*:IContentServerDirectoryService
    IPublishedFileService*:IPublishedFileService
    IEconService*:IEconService
    IGameNotificationsService*:IGameNotificationsService
    IInventoryService*:IInventoryService
    IStoreService*:IStoreService
    ICheatReportingService*:ICheatReportingService
  AsyncSteamWebAPI* = object
    ## Async steam WebAPI client
    IClientStats_1046930*: AsyncIClientStats_1046930
    ICSGOPlayers_730*: AsyncICSGOPlayers_730
    ICSGOServers_730*: AsyncICSGOServers_730
    ICSGOTournaments_730*: AsyncICSGOTournaments_730
    IDOTA2Fantasy_205790*: AsyncIDOTA2Fantasy_205790
    IDOTA2MatchStats_205790*: AsyncIDOTA2MatchStats_205790
    IDOTA2MatchStats_570*: AsyncIDOTA2MatchStats_570
    IDOTA2Match_205790*: AsyncIDOTA2Match_205790
    IDOTA2Match_570*: AsyncIDOTA2Match_570
    IDOTA2StreamSystem_205790*: AsyncIDOTA2StreamSystem_205790
    IDOTA2StreamSystem_570*: AsyncIDOTA2StreamSystem_570
    IDOTA2Ticket_205790*: AsyncIDOTA2Ticket_205790
    IDOTA2Ticket_570*: AsyncIDOTA2Ticket_570
    IEconDOTA2_205790*: AsyncIEconDOTA2_205790
    IEconDOTA2_570*: AsyncIEconDOTA2_570
    IEconItems_1046930*: AsyncIEconItems_1046930
    IEconItems_1269260*: AsyncIEconItems_1269260
    IEconItems_205790*: AsyncIEconItems_205790
    IEconItems_221540*: AsyncIEconItems_221540
    IEconItems_238460*: AsyncIEconItems_238460
    IEconItems_440*: AsyncIEconItems_440
    IEconItems_570*: AsyncIEconItems_570
    IEconItems_583950*: AsyncIEconItems_583950
    IEconItems_620*: AsyncIEconItems_620
    IEconItems_730*: AsyncIEconItems_730
    IGCVersion_1046930*: AsyncIGCVersion_1046930
    IGCVersion_1269260*: AsyncIGCVersion_1269260
    IGCVersion_205790*: AsyncIGCVersion_205790
    IGCVersion_440*: AsyncIGCVersion_440
    IGCVersion_570*: AsyncIGCVersion_570
    IGCVersion_583950*: AsyncIGCVersion_583950
    IGCVersion_730*: AsyncIGCVersion_730
    IPortal2Leaderboards_620*: AsyncIPortal2Leaderboards_620
    ISteamApps*: AsyncISteamApps
    ISteamBroadcast*: AsyncISteamBroadcast
    ISteamCDN*: AsyncISteamCDN
    ISteamDirectory*: AsyncISteamDirectory
    ISteamEconomy*: AsyncISteamEconomy
    ISteamNews*: AsyncISteamNews
    ISteamRemoteStorage*: AsyncISteamRemoteStorage
    ISteamUser*: AsyncISteamUser
    ISteamUserAuth*: AsyncISteamUserAuth
    ISteamUserOAuth*: AsyncISteamUserOAuth
    ISteamUserStats*: AsyncISteamUserStats
    ISteamWebAPIUtil*: AsyncISteamWebAPIUtil
    ISteamWebUserPresenceOAuth*: AsyncISteamWebUserPresenceOAuth
    ITFItems_440*: AsyncITFItems_440
    ITFPromos_205790*: AsyncITFPromos_205790
    ITFPromos_440*: AsyncITFPromos_440
    ITFPromos_620*: AsyncITFPromos_620
    ITFSystem_440*: AsyncITFSystem_440
    IGameServersService*: AsyncIGameServersService
    IPlayerService*: AsyncIPlayerService
    IBroadcastService*: AsyncIBroadcastService
    IContentServerConfigService*: AsyncIContentServerConfigService
    IContentServerDirectoryService*: AsyncIContentServerDirectoryService
    IPublishedFileService*: AsyncIPublishedFileService
    IEconService*: AsyncIEconService
    IGameNotificationsService*: AsyncIGameNotificationsService
    IInventoryService*: AsyncIInventoryService
    IStoreService*: AsyncIStoreService
    ICheatReportingService*: AsyncICheatReportingService
  IClientStats_1046930 = object 
    name*:string
    methods*: seq[string]
  AsyncIClientStats_1046930 =  object 
    name*:string
    methods*: seq[string]
  ICSGOPlayers_730 = object 
    name*:string
    methods*: seq[string]
  AsyncICSGOPlayers_730 =  object 
    name*:string
    methods*: seq[string]
  ICSGOServers_730 = object 
    name*:string
    methods*: seq[string]
  AsyncICSGOServers_730 =  object 
    name*:string
    methods*: seq[string]
  ICSGOTournaments_730 = object 
    name*:string
    methods*: seq[string]
  AsyncICSGOTournaments_730 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2Fantasy_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2Fantasy_205790 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2MatchStats_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2MatchStats_205790 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2MatchStats_570 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2MatchStats_570 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2Match_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2Match_205790 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2Match_570 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2Match_570 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2StreamSystem_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2StreamSystem_205790 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2StreamSystem_570 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2StreamSystem_570 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2Ticket_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2Ticket_205790 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2Ticket_570 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2Ticket_570 =  object 
    name*:string
    methods*: seq[string]
  IEconDOTA2_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconDOTA2_205790 =  object 
    name*:string
    methods*: seq[string]
  IEconDOTA2_570 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconDOTA2_570 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_1046930 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_1046930 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_1269260 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_1269260 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_205790 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_221540 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_221540 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_238460 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_238460 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_440 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_440 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_570 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_570 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_583950 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_583950 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_620 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_620 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_730 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_730 =  object 
    name*:string
    methods*: seq[string]
  IGCVersion_1046930 = object 
    name*:string
    methods*: seq[string]
  AsyncIGCVersion_1046930 =  object 
    name*:string
    methods*: seq[string]
  IGCVersion_1269260 = object 
    name*:string
    methods*: seq[string]
  AsyncIGCVersion_1269260 =  object 
    name*:string
    methods*: seq[string]
  IGCVersion_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIGCVersion_205790 =  object 
    name*:string
    methods*: seq[string]
  IGCVersion_440 = object 
    name*:string
    methods*: seq[string]
  AsyncIGCVersion_440 =  object 
    name*:string
    methods*: seq[string]
  IGCVersion_570 = object 
    name*:string
    methods*: seq[string]
  AsyncIGCVersion_570 =  object 
    name*:string
    methods*: seq[string]
  IGCVersion_583950 = object 
    name*:string
    methods*: seq[string]
  AsyncIGCVersion_583950 =  object 
    name*:string
    methods*: seq[string]
  IGCVersion_730 = object 
    name*:string
    methods*: seq[string]
  AsyncIGCVersion_730 =  object 
    name*:string
    methods*: seq[string]
  IPortal2Leaderboards_620 = object 
    name*:string
    methods*: seq[string]
  AsyncIPortal2Leaderboards_620 =  object 
    name*:string
    methods*: seq[string]
  ISteamApps = object 
    name*:string
    methods*: seq[string]
  AsyncISteamApps =  object 
    name*:string
    methods*: seq[string]
  ISteamBroadcast = object 
    name*:string
    methods*: seq[string]
  AsyncISteamBroadcast =  object 
    name*:string
    methods*: seq[string]
  ISteamCDN = object 
    name*:string
    methods*: seq[string]
  AsyncISteamCDN =  object 
    name*:string
    methods*: seq[string]
  ISteamDirectory = object 
    name*:string
    methods*: seq[string]
  AsyncISteamDirectory =  object 
    name*:string
    methods*: seq[string]
  ISteamEconomy = object 
    name*:string
    methods*: seq[string]
  AsyncISteamEconomy =  object 
    name*:string
    methods*: seq[string]
  ISteamNews = object 
    name*:string
    methods*: seq[string]
  AsyncISteamNews =  object 
    name*:string
    methods*: seq[string]
  ISteamRemoteStorage = object 
    name*:string
    methods*: seq[string]
  AsyncISteamRemoteStorage =  object 
    name*:string
    methods*: seq[string]
  ISteamUser = object 
    name*:string
    methods*: seq[string]
  AsyncISteamUser =  object 
    name*:string
    methods*: seq[string]
  ISteamUserAuth = object 
    name*:string
    methods*: seq[string]
  AsyncISteamUserAuth =  object 
    name*:string
    methods*: seq[string]
  ISteamUserOAuth = object 
    name*:string
    methods*: seq[string]
  AsyncISteamUserOAuth =  object 
    name*:string
    methods*: seq[string]
  ISteamUserStats = object 
    name*:string
    methods*: seq[string]
  AsyncISteamUserStats =  object 
    name*:string
    methods*: seq[string]
  ISteamWebAPIUtil = object 
    name*:string
    methods*: seq[string]
  AsyncISteamWebAPIUtil =  object 
    name*:string
    methods*: seq[string]
  ISteamWebUserPresenceOAuth = object 
    name*:string
    methods*: seq[string]
  AsyncISteamWebUserPresenceOAuth =  object 
    name*:string
    methods*: seq[string]
  ITFItems_440 = object 
    name*:string
    methods*: seq[string]
  AsyncITFItems_440 =  object 
    name*:string
    methods*: seq[string]
  ITFPromos_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncITFPromos_205790 =  object 
    name*:string
    methods*: seq[string]
  ITFPromos_440 = object 
    name*:string
    methods*: seq[string]
  AsyncITFPromos_440 =  object 
    name*:string
    methods*: seq[string]
  ITFPromos_620 = object 
    name*:string
    methods*: seq[string]
  AsyncITFPromos_620 =  object 
    name*:string
    methods*: seq[string]
  ITFSystem_440 = object 
    name*:string
    methods*: seq[string]
  AsyncITFSystem_440 =  object 
    name*:string
    methods*: seq[string]
  IGameServersService = object 
    name*:string
    methods*: seq[string]
  AsyncIGameServersService =  object 
    name*:string
    methods*: seq[string]
  IPlayerService = object 
    name*:string
    methods*: seq[string]
  AsyncIPlayerService =  object 
    name*:string
    methods*: seq[string]
  IBroadcastService = object 
    name*:string
    methods*: seq[string]
  AsyncIBroadcastService =  object 
    name*:string
    methods*: seq[string]
  IContentServerConfigService = object 
    name*:string
    methods*: seq[string]
  AsyncIContentServerConfigService =  object 
    name*:string
    methods*: seq[string]
  IContentServerDirectoryService = object 
    name*:string
    methods*: seq[string]
  AsyncIContentServerDirectoryService =  object 
    name*:string
    methods*: seq[string]
  IPublishedFileService = object 
    name*:string
    methods*: seq[string]
  AsyncIPublishedFileService =  object 
    name*:string
    methods*: seq[string]
  IEconService = object 
    name*:string
    methods*: seq[string]
  AsyncIEconService =  object 
    name*:string
    methods*: seq[string]
  IGameNotificationsService = object 
    name*:string
    methods*: seq[string]
  AsyncIGameNotificationsService =  object 
    name*:string
    methods*: seq[string]
  IInventoryService = object 
    name*:string
    methods*: seq[string]
  AsyncIInventoryService =  object 
    name*:string
    methods*: seq[string]
  IStoreService = object 
    name*:string
    methods*: seq[string]
  AsyncIStoreService =  object 
    name*:string
    methods*: seq[string]
  ICheatReportingService = object 
    name*:string
    methods*: seq[string]
  AsyncICheatReportingService =  object 
    name*:string
    methods*: seq[string]

proc newSteamWebAPI*():SteamWebAPI=
  result.IClientStats_1046930.name = "IClientStats_1046930"
  result.IClientStats_1046930.methods.add("ReportEvent:V1")
  result.ICSGOPlayers_730.name = "ICSGOPlayers_730"
  result.ICSGOPlayers_730.methods.add("GetNextMatchSharingCode:V1")
  result.ICSGOServers_730.name = "ICSGOServers_730"
  result.ICSGOServers_730.methods.add("GetGameMapsPlaytime:V1")
  result.ICSGOServers_730.methods.add("GetGameServersStatus:V1")
  result.ICSGOTournaments_730.name = "ICSGOTournaments_730"
  result.ICSGOTournaments_730.methods.add("GetTournamentFantasyLineup:V1")
  result.ICSGOTournaments_730.methods.add("GetTournamentItems:V1")
  result.ICSGOTournaments_730.methods.add("GetTournamentLayout:V1")
  result.ICSGOTournaments_730.methods.add("GetTournamentPredictions:V1")
  result.ICSGOTournaments_730.methods.add("UploadTournamentFantasyLineup:V1")
  result.ICSGOTournaments_730.methods.add("UploadTournamentPredictions:V1")
  result.IDOTA2Fantasy_205790.name = "IDOTA2Fantasy_205790"
  result.IDOTA2Fantasy_205790.methods.add("GetFantasyPlayerStats:V1")
  result.IDOTA2Fantasy_205790.methods.add("GetPlayerOfficialInfo:V1")
  result.IDOTA2Fantasy_205790.methods.add("GetProPlayerList:V1")
  result.IDOTA2MatchStats_205790.name = "IDOTA2MatchStats_205790"
  result.IDOTA2MatchStats_205790.methods.add("GetRealtimeStats:V1")
  result.IDOTA2MatchStats_570.name = "IDOTA2MatchStats_570"
  result.IDOTA2MatchStats_570.methods.add("GetRealtimeStats:V1")
  result.IDOTA2Match_205790.name = "IDOTA2Match_205790"
  result.IDOTA2Match_205790.methods.add("GetLeagueListing:V1")
  result.IDOTA2Match_205790.methods.add("GetLiveLeagueGames:V1")
  result.IDOTA2Match_205790.methods.add("GetMatchDetails:V1")
  result.IDOTA2Match_205790.methods.add("GetMatchHistory:V1")
  result.IDOTA2Match_205790.methods.add("GetMatchHistoryBySequenceNum:V1")
  result.IDOTA2Match_205790.methods.add("GetTeamInfoByTeamID:V1")
  result.IDOTA2Match_205790.methods.add("GetTopLiveEventGame:V1")
  result.IDOTA2Match_205790.methods.add("GetTopLiveGame:V1")
  result.IDOTA2Match_205790.methods.add("GetTopWeekendTourneyGames:V1")
  result.IDOTA2Match_205790.methods.add("GetTournamentPlayerStats:V1")
  result.IDOTA2Match_205790.methods.add("GetTournamentPlayerStats:V2")
  result.IDOTA2Match_570.name = "IDOTA2Match_570"
  result.IDOTA2Match_570.methods.add("GetLiveLeagueGames:V1")
  result.IDOTA2Match_570.methods.add("GetMatchDetails:V1")
  result.IDOTA2Match_570.methods.add("GetMatchHistory:V1")
  result.IDOTA2Match_570.methods.add("GetMatchHistoryBySequenceNum:V1")
  result.IDOTA2Match_570.methods.add("GetTeamInfoByTeamID:V1")
  result.IDOTA2Match_570.methods.add("GetTopLiveEventGame:V1")
  result.IDOTA2Match_570.methods.add("GetTopLiveGame:V1")
  result.IDOTA2Match_570.methods.add("GetTopWeekendTourneyGames:V1")
  result.IDOTA2Match_570.methods.add("GetTournamentPlayerStats:V1")
  result.IDOTA2Match_570.methods.add("GetTournamentPlayerStats:V2")
  result.IDOTA2StreamSystem_205790.name = "IDOTA2StreamSystem_205790"
  result.IDOTA2StreamSystem_205790.methods.add("GetBroadcasterInfo:V1")
  result.IDOTA2StreamSystem_570.name = "IDOTA2StreamSystem_570"
  result.IDOTA2StreamSystem_570.methods.add("GetBroadcasterInfo:V1")
  result.IDOTA2Ticket_205790.name = "IDOTA2Ticket_205790"
  result.IDOTA2Ticket_205790.methods.add("ClaimBadgeReward:V1")
  result.IDOTA2Ticket_205790.methods.add("GetSteamIDForBadgeID:V1")
  result.IDOTA2Ticket_205790.methods.add("SetSteamAccountPurchased:V1")
  result.IDOTA2Ticket_205790.methods.add("SteamAccountValidForBadgeType:V1")
  result.IDOTA2Ticket_570.name = "IDOTA2Ticket_570"
  result.IDOTA2Ticket_570.methods.add("SetSteamAccountPurchased:V1")
  result.IDOTA2Ticket_570.methods.add("SteamAccountValidForBadgeType:V1")
  result.IEconDOTA2_205790.name = "IEconDOTA2_205790"
  result.IEconDOTA2_205790.methods.add("GetEventStatsForAccount:V1")
  result.IEconDOTA2_205790.methods.add("GetGameItems:V1")
  result.IEconDOTA2_205790.methods.add("GetHeroes:V1")
  result.IEconDOTA2_205790.methods.add("GetItemIconPath:V1")
  result.IEconDOTA2_205790.methods.add("GetRarities:V1")
  result.IEconDOTA2_205790.methods.add("GetTournamentPrizePool:V1")
  result.IEconDOTA2_570.name = "IEconDOTA2_570"
  result.IEconDOTA2_570.methods.add("GetEventStatsForAccount:V1")
  result.IEconDOTA2_570.methods.add("GetGameItems:V1")
  result.IEconDOTA2_570.methods.add("GetHeroes:V1")
  result.IEconDOTA2_570.methods.add("GetItemCreators:V1")
  result.IEconDOTA2_570.methods.add("GetItemWorkshopPublishedFileIDs:V1")
  result.IEconDOTA2_570.methods.add("GetRarities:V1")
  result.IEconDOTA2_570.methods.add("GetTournamentPrizePool:V1")
  result.IEconItems_1046930.name = "IEconItems_1046930"
  result.IEconItems_1046930.methods.add("GetPlayerItems:V1")
  result.IEconItems_1269260.name = "IEconItems_1269260"
  result.IEconItems_1269260.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_205790.name = "IEconItems_205790"
  result.IEconItems_205790.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_205790.methods.add("GetPlayerItems:V1")
  result.IEconItems_205790.methods.add("GetSchemaURL:V1")
  result.IEconItems_205790.methods.add("GetStoreMetaData:V1")
  result.IEconItems_221540.name = "IEconItems_221540"
  result.IEconItems_221540.methods.add("GetPlayerItems:V1")
  result.IEconItems_238460.name = "IEconItems_238460"
  result.IEconItems_238460.methods.add("GetPlayerItems:V1")
  result.IEconItems_440.name = "IEconItems_440"
  result.IEconItems_440.methods.add("GetPlayerItems:V1")
  result.IEconItems_440.methods.add("GetSchema:V1")
  result.IEconItems_440.methods.add("GetSchemaItems:V1")
  result.IEconItems_440.methods.add("GetSchemaOverview:V1")
  result.IEconItems_440.methods.add("GetSchemaURL:V1")
  result.IEconItems_440.methods.add("GetStoreMetaData:V1")
  result.IEconItems_440.methods.add("GetStoreStatus:V1")
  result.IEconItems_570.name = "IEconItems_570"
  result.IEconItems_570.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_570.methods.add("GetPlayerItems:V1")
  result.IEconItems_570.methods.add("GetStoreMetaData:V1")
  result.IEconItems_583950.name = "IEconItems_583950"
  result.IEconItems_583950.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_620.name = "IEconItems_620"
  result.IEconItems_620.methods.add("GetPlayerItems:V1")
  result.IEconItems_620.methods.add("GetSchema:V1")
  result.IEconItems_730.name = "IEconItems_730"
  result.IEconItems_730.methods.add("GetPlayerItems:V1")
  result.IEconItems_730.methods.add("GetSchema:V2")
  result.IEconItems_730.methods.add("GetSchemaURL:V2")
  result.IEconItems_730.methods.add("GetStoreMetaData:V1")
  result.IGCVersion_1046930.name = "IGCVersion_1046930"
  result.IGCVersion_1046930.methods.add("GetClientVersion:V1")
  result.IGCVersion_1046930.methods.add("GetServerVersion:V1")
  result.IGCVersion_1269260.name = "IGCVersion_1269260"
  result.IGCVersion_1269260.methods.add("GetClientVersion:V1")
  result.IGCVersion_1269260.methods.add("GetServerVersion:V1")
  result.IGCVersion_205790.name = "IGCVersion_205790"
  result.IGCVersion_205790.methods.add("GetClientVersion:V1")
  result.IGCVersion_205790.methods.add("GetServerVersion:V1")
  result.IGCVersion_440.name = "IGCVersion_440"
  result.IGCVersion_440.methods.add("GetClientVersion:V1")
  result.IGCVersion_440.methods.add("GetServerVersion:V1")
  result.IGCVersion_570.name = "IGCVersion_570"
  result.IGCVersion_570.methods.add("GetClientVersion:V1")
  result.IGCVersion_570.methods.add("GetServerVersion:V1")
  result.IGCVersion_583950.name = "IGCVersion_583950"
  result.IGCVersion_583950.methods.add("GetClientVersion:V1")
  result.IGCVersion_583950.methods.add("GetServerVersion:V1")
  result.IGCVersion_730.name = "IGCVersion_730"
  result.IGCVersion_730.methods.add("GetServerVersion:V1")
  result.IPortal2Leaderboards_620.name = "IPortal2Leaderboards_620"
  result.IPortal2Leaderboards_620.methods.add("GetBucketizedData:V1")
  result.ISteamApps.name = "ISteamApps"
  result.ISteamApps.methods.add("GetAppList:V1")
  result.ISteamApps.methods.add("GetAppList:V2")
  result.ISteamApps.methods.add("GetSDRConfig:V1")
  result.ISteamApps.methods.add("GetServersAtAddress:V1")
  result.ISteamApps.methods.add("UpToDateCheck:V1")
  result.ISteamBroadcast.name = "ISteamBroadcast"
  result.ISteamBroadcast.methods.add("ViewerHeartbeat:V1")
  result.ISteamCDN.name = "ISteamCDN"
  result.ISteamCDN.methods.add("SetClientFilters:V1")
  result.ISteamCDN.methods.add("SetPerformanceStats:V1")
  result.ISteamDirectory.name = "ISteamDirectory"
  result.ISteamDirectory.methods.add("GetCMList:V1")
  result.ISteamDirectory.methods.add("GetCMListForConnect:V1")
  result.ISteamDirectory.methods.add("GetSteamPipeDomains:V1")
  result.ISteamEconomy.name = "ISteamEconomy"
  result.ISteamEconomy.methods.add("GetAssetClassInfo:V1")
  result.ISteamEconomy.methods.add("GetAssetPrices:V1")
  result.ISteamNews.name = "ISteamNews"
  result.ISteamNews.methods.add("GetNewsForApp:V1")
  result.ISteamNews.methods.add("GetNewsForApp:V2")
  result.ISteamRemoteStorage.name = "ISteamRemoteStorage"
  result.ISteamRemoteStorage.methods.add("GetCollectionDetails:V1")
  result.ISteamRemoteStorage.methods.add("GetPublishedFileDetails:V1")
  result.ISteamRemoteStorage.methods.add("GetUGCFileDetails:V1")
  result.ISteamUser.name = "ISteamUser"
  result.ISteamUser.methods.add("GetFriendList:V1")
  result.ISteamUser.methods.add("GetPlayerBans:V1")
  result.ISteamUser.methods.add("GetPlayerSummaries:V1")
  result.ISteamUser.methods.add("GetPlayerSummaries:V2")
  result.ISteamUser.methods.add("GetUserGroupList:V1")
  result.ISteamUser.methods.add("ResolveVanityURL:V1")
  result.ISteamUserAuth.name = "ISteamUserAuth"
  result.ISteamUserAuth.methods.add("AuthenticateUser:V1")
  result.ISteamUserAuth.methods.add("AuthenticateUserTicket:V1")
  result.ISteamUserOAuth.name = "ISteamUserOAuth"
  result.ISteamUserOAuth.methods.add("GetTokenDetails:V1")
  result.ISteamUserStats.name = "ISteamUserStats"
  result.ISteamUserStats.methods.add("GetGlobalAchievementPercentagesForApp:V1")
  result.ISteamUserStats.methods.add("GetGlobalAchievementPercentagesForApp:V2")
  result.ISteamUserStats.methods.add("GetGlobalStatsForGame:V1")
  result.ISteamUserStats.methods.add("GetNumberOfCurrentPlayers:V1")
  result.ISteamUserStats.methods.add("GetPlayerAchievements:V1")
  result.ISteamUserStats.methods.add("GetSchemaForGame:V1")
  result.ISteamUserStats.methods.add("GetSchemaForGame:V2")
  result.ISteamUserStats.methods.add("GetUserStatsForGame:V1")
  result.ISteamUserStats.methods.add("GetUserStatsForGame:V2")
  result.ISteamWebAPIUtil.name = "ISteamWebAPIUtil"
  result.ISteamWebAPIUtil.methods.add("GetServerInfo:V1")
  result.ISteamWebAPIUtil.methods.add("GetSupportedAPIList:V1")
  result.ISteamWebUserPresenceOAuth.name = "ISteamWebUserPresenceOAuth"
  result.ISteamWebUserPresenceOAuth.methods.add("PollStatus:V1")
  result.ITFItems_440.name = "ITFItems_440"
  result.ITFItems_440.methods.add("GetGoldenWrenches:V1")
  result.ITFItems_440.methods.add("GetGoldenWrenches:V2")
  result.ITFPromos_205790.name = "ITFPromos_205790"
  result.ITFPromos_205790.methods.add("GetItemID:V1")
  result.ITFPromos_205790.methods.add("GrantItem:V1")
  result.ITFPromos_440.name = "ITFPromos_440"
  result.ITFPromos_440.methods.add("GetItemID:V1")
  result.ITFPromos_440.methods.add("GrantItem:V1")
  result.ITFPromos_620.name = "ITFPromos_620"
  result.ITFPromos_620.methods.add("GetItemID:V1")
  result.ITFPromos_620.methods.add("GrantItem:V1")
  result.ITFSystem_440.name = "ITFSystem_440"
  result.ITFSystem_440.methods.add("GetWorldStatus:V1")
  result.IGameServersService.name = "IGameServersService"
  result.IGameServersService.methods.add("GetAccountList:V1")
  result.IGameServersService.methods.add("CreateAccount:V1")
  result.IGameServersService.methods.add("SetMemo:V1")
  result.IGameServersService.methods.add("ResetLoginToken:V1")
  result.IGameServersService.methods.add("DeleteAccount:V1")
  result.IGameServersService.methods.add("GetAccountPublicInfo:V1")
  result.IGameServersService.methods.add("QueryLoginToken:V1")
  result.IGameServersService.methods.add("GetServerSteamIDsByIP:V1")
  result.IGameServersService.methods.add("GetServerIPsBySteamID:V1")
  result.IGameServersService.methods.add("QueryByFakeIP:V1")
  result.IPlayerService.name = "IPlayerService"
  result.IPlayerService.methods.add("IsPlayingSharedGame:V1")
  result.IPlayerService.methods.add("RecordOfflinePlaytime:V1")
  result.IPlayerService.methods.add("GetRecentlyPlayedGames:V1")
  result.IPlayerService.methods.add("GetOwnedGames:V1")
  result.IPlayerService.methods.add("GetSteamLevel:V1")
  result.IPlayerService.methods.add("GetBadges:V1")
  result.IPlayerService.methods.add("GetCommunityBadgeProgress:V1")
  result.IBroadcastService.name = "IBroadcastService"
  result.IBroadcastService.methods.add("PostGameDataFrameRTMP:V1")
  result.IContentServerConfigService.name = "IContentServerConfigService"
  result.IContentServerConfigService.methods.add("SetSteamCacheClientFilters:V1")
  result.IContentServerConfigService.methods.add("GetSteamCacheNodeParams:V1")
  result.IContentServerConfigService.methods.add("SetSteamCachePerformanceStats:V1")
  result.IContentServerDirectoryService.name = "IContentServerDirectoryService"
  result.IContentServerDirectoryService.methods.add("GetServersForSteamPipe:V1")
  result.IContentServerDirectoryService.methods.add("GetClientUpdateHosts:V1")
  result.IContentServerDirectoryService.methods.add("GetDepotPatchInfo:V1")
  result.IPublishedFileService.name = "IPublishedFileService"
  result.IPublishedFileService.methods.add("GetUserVoteSummary:V1")
  result.IPublishedFileService.methods.add("QueryFiles:V1")
  result.IPublishedFileService.methods.add("GetDetails:V1")
  result.IPublishedFileService.methods.add("GetUserFiles:V1")
  result.IEconService.name = "IEconService"
  result.IEconService.methods.add("GetTradeHistory:V1")
  result.IEconService.methods.add("GetTradeStatus:V1")
  result.IEconService.methods.add("GetTradeOffers:V1")
  result.IEconService.methods.add("GetTradeOffer:V1")
  result.IEconService.methods.add("GetTradeOffersSummary:V1")
  result.IEconService.methods.add("GetTradeHoldDurations:V1")
  result.IGameNotificationsService.name = "IGameNotificationsService"
  result.IGameNotificationsService.methods.add("UserCreateSession:V1")
  result.IGameNotificationsService.methods.add("UserUpdateSession:V1")
  result.IGameNotificationsService.methods.add("UserDeleteSession:V1")
  result.IInventoryService.name = "IInventoryService"
  result.IInventoryService.methods.add("SplitItemStack:V1")
  result.IInventoryService.methods.add("CombineItemStacks:V1")
  result.IInventoryService.methods.add("GetPriceSheet:V1")
  result.IStoreService.name = "IStoreService"
  result.IStoreService.methods.add("GetAppList:V1")
  result.ICheatReportingService.name = "ICheatReportingService"
  result.ICheatReportingService.methods.add("ReportCheatData:V1")
  return result


proc newAsyncSteamWebAPI*():AsyncSteamWebAPI=
  result.IClientStats_1046930.name = "IClientStats_1046930"
  result.IClientStats_1046930.methods.add("ReportEvent:V1")
  result.ICSGOPlayers_730.name = "ICSGOPlayers_730"
  result.ICSGOPlayers_730.methods.add("GetNextMatchSharingCode:V1")
  result.ICSGOServers_730.name = "ICSGOServers_730"
  result.ICSGOServers_730.methods.add("GetGameMapsPlaytime:V1")
  result.ICSGOServers_730.methods.add("GetGameServersStatus:V1")
  result.ICSGOTournaments_730.name = "ICSGOTournaments_730"
  result.ICSGOTournaments_730.methods.add("GetTournamentFantasyLineup:V1")
  result.ICSGOTournaments_730.methods.add("GetTournamentItems:V1")
  result.ICSGOTournaments_730.methods.add("GetTournamentLayout:V1")
  result.ICSGOTournaments_730.methods.add("GetTournamentPredictions:V1")
  result.ICSGOTournaments_730.methods.add("UploadTournamentFantasyLineup:V1")
  result.ICSGOTournaments_730.methods.add("UploadTournamentPredictions:V1")
  result.IDOTA2Fantasy_205790.name = "IDOTA2Fantasy_205790"
  result.IDOTA2Fantasy_205790.methods.add("GetFantasyPlayerStats:V1")
  result.IDOTA2Fantasy_205790.methods.add("GetPlayerOfficialInfo:V1")
  result.IDOTA2Fantasy_205790.methods.add("GetProPlayerList:V1")
  result.IDOTA2MatchStats_205790.name = "IDOTA2MatchStats_205790"
  result.IDOTA2MatchStats_205790.methods.add("GetRealtimeStats:V1")
  result.IDOTA2MatchStats_570.name = "IDOTA2MatchStats_570"
  result.IDOTA2MatchStats_570.methods.add("GetRealtimeStats:V1")
  result.IDOTA2Match_205790.name = "IDOTA2Match_205790"
  result.IDOTA2Match_205790.methods.add("GetLeagueListing:V1")
  result.IDOTA2Match_205790.methods.add("GetLiveLeagueGames:V1")
  result.IDOTA2Match_205790.methods.add("GetMatchDetails:V1")
  result.IDOTA2Match_205790.methods.add("GetMatchHistory:V1")
  result.IDOTA2Match_205790.methods.add("GetMatchHistoryBySequenceNum:V1")
  result.IDOTA2Match_205790.methods.add("GetTeamInfoByTeamID:V1")
  result.IDOTA2Match_205790.methods.add("GetTopLiveEventGame:V1")
  result.IDOTA2Match_205790.methods.add("GetTopLiveGame:V1")
  result.IDOTA2Match_205790.methods.add("GetTopWeekendTourneyGames:V1")
  result.IDOTA2Match_205790.methods.add("GetTournamentPlayerStats:V1")
  result.IDOTA2Match_205790.methods.add("GetTournamentPlayerStats:V2")
  result.IDOTA2Match_570.name = "IDOTA2Match_570"
  result.IDOTA2Match_570.methods.add("GetLiveLeagueGames:V1")
  result.IDOTA2Match_570.methods.add("GetMatchDetails:V1")
  result.IDOTA2Match_570.methods.add("GetMatchHistory:V1")
  result.IDOTA2Match_570.methods.add("GetMatchHistoryBySequenceNum:V1")
  result.IDOTA2Match_570.methods.add("GetTeamInfoByTeamID:V1")
  result.IDOTA2Match_570.methods.add("GetTopLiveEventGame:V1")
  result.IDOTA2Match_570.methods.add("GetTopLiveGame:V1")
  result.IDOTA2Match_570.methods.add("GetTopWeekendTourneyGames:V1")
  result.IDOTA2Match_570.methods.add("GetTournamentPlayerStats:V1")
  result.IDOTA2Match_570.methods.add("GetTournamentPlayerStats:V2")
  result.IDOTA2StreamSystem_205790.name = "IDOTA2StreamSystem_205790"
  result.IDOTA2StreamSystem_205790.methods.add("GetBroadcasterInfo:V1")
  result.IDOTA2StreamSystem_570.name = "IDOTA2StreamSystem_570"
  result.IDOTA2StreamSystem_570.methods.add("GetBroadcasterInfo:V1")
  result.IDOTA2Ticket_205790.name = "IDOTA2Ticket_205790"
  result.IDOTA2Ticket_205790.methods.add("ClaimBadgeReward:V1")
  result.IDOTA2Ticket_205790.methods.add("GetSteamIDForBadgeID:V1")
  result.IDOTA2Ticket_205790.methods.add("SetSteamAccountPurchased:V1")
  result.IDOTA2Ticket_205790.methods.add("SteamAccountValidForBadgeType:V1")
  result.IDOTA2Ticket_570.name = "IDOTA2Ticket_570"
  result.IDOTA2Ticket_570.methods.add("SetSteamAccountPurchased:V1")
  result.IDOTA2Ticket_570.methods.add("SteamAccountValidForBadgeType:V1")
  result.IEconDOTA2_205790.name = "IEconDOTA2_205790"
  result.IEconDOTA2_205790.methods.add("GetEventStatsForAccount:V1")
  result.IEconDOTA2_205790.methods.add("GetGameItems:V1")
  result.IEconDOTA2_205790.methods.add("GetHeroes:V1")
  result.IEconDOTA2_205790.methods.add("GetItemIconPath:V1")
  result.IEconDOTA2_205790.methods.add("GetRarities:V1")
  result.IEconDOTA2_205790.methods.add("GetTournamentPrizePool:V1")
  result.IEconDOTA2_570.name = "IEconDOTA2_570"
  result.IEconDOTA2_570.methods.add("GetEventStatsForAccount:V1")
  result.IEconDOTA2_570.methods.add("GetGameItems:V1")
  result.IEconDOTA2_570.methods.add("GetHeroes:V1")
  result.IEconDOTA2_570.methods.add("GetItemCreators:V1")
  result.IEconDOTA2_570.methods.add("GetItemWorkshopPublishedFileIDs:V1")
  result.IEconDOTA2_570.methods.add("GetRarities:V1")
  result.IEconDOTA2_570.methods.add("GetTournamentPrizePool:V1")
  result.IEconItems_1046930.name = "IEconItems_1046930"
  result.IEconItems_1046930.methods.add("GetPlayerItems:V1")
  result.IEconItems_1269260.name = "IEconItems_1269260"
  result.IEconItems_1269260.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_205790.name = "IEconItems_205790"
  result.IEconItems_205790.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_205790.methods.add("GetPlayerItems:V1")
  result.IEconItems_205790.methods.add("GetSchemaURL:V1")
  result.IEconItems_205790.methods.add("GetStoreMetaData:V1")
  result.IEconItems_221540.name = "IEconItems_221540"
  result.IEconItems_221540.methods.add("GetPlayerItems:V1")
  result.IEconItems_238460.name = "IEconItems_238460"
  result.IEconItems_238460.methods.add("GetPlayerItems:V1")
  result.IEconItems_440.name = "IEconItems_440"
  result.IEconItems_440.methods.add("GetPlayerItems:V1")
  result.IEconItems_440.methods.add("GetSchema:V1")
  result.IEconItems_440.methods.add("GetSchemaItems:V1")
  result.IEconItems_440.methods.add("GetSchemaOverview:V1")
  result.IEconItems_440.methods.add("GetSchemaURL:V1")
  result.IEconItems_440.methods.add("GetStoreMetaData:V1")
  result.IEconItems_440.methods.add("GetStoreStatus:V1")
  result.IEconItems_570.name = "IEconItems_570"
  result.IEconItems_570.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_570.methods.add("GetPlayerItems:V1")
  result.IEconItems_570.methods.add("GetStoreMetaData:V1")
  result.IEconItems_583950.name = "IEconItems_583950"
  result.IEconItems_583950.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_620.name = "IEconItems_620"
  result.IEconItems_620.methods.add("GetPlayerItems:V1")
  result.IEconItems_620.methods.add("GetSchema:V1")
  result.IEconItems_730.name = "IEconItems_730"
  result.IEconItems_730.methods.add("GetPlayerItems:V1")
  result.IEconItems_730.methods.add("GetSchema:V2")
  result.IEconItems_730.methods.add("GetSchemaURL:V2")
  result.IEconItems_730.methods.add("GetStoreMetaData:V1")
  result.IGCVersion_1046930.name = "IGCVersion_1046930"
  result.IGCVersion_1046930.methods.add("GetClientVersion:V1")
  result.IGCVersion_1046930.methods.add("GetServerVersion:V1")
  result.IGCVersion_1269260.name = "IGCVersion_1269260"
  result.IGCVersion_1269260.methods.add("GetClientVersion:V1")
  result.IGCVersion_1269260.methods.add("GetServerVersion:V1")
  result.IGCVersion_205790.name = "IGCVersion_205790"
  result.IGCVersion_205790.methods.add("GetClientVersion:V1")
  result.IGCVersion_205790.methods.add("GetServerVersion:V1")
  result.IGCVersion_440.name = "IGCVersion_440"
  result.IGCVersion_440.methods.add("GetClientVersion:V1")
  result.IGCVersion_440.methods.add("GetServerVersion:V1")
  result.IGCVersion_570.name = "IGCVersion_570"
  result.IGCVersion_570.methods.add("GetClientVersion:V1")
  result.IGCVersion_570.methods.add("GetServerVersion:V1")
  result.IGCVersion_583950.name = "IGCVersion_583950"
  result.IGCVersion_583950.methods.add("GetClientVersion:V1")
  result.IGCVersion_583950.methods.add("GetServerVersion:V1")
  result.IGCVersion_730.name = "IGCVersion_730"
  result.IGCVersion_730.methods.add("GetServerVersion:V1")
  result.IPortal2Leaderboards_620.name = "IPortal2Leaderboards_620"
  result.IPortal2Leaderboards_620.methods.add("GetBucketizedData:V1")
  result.ISteamApps.name = "ISteamApps"
  result.ISteamApps.methods.add("GetAppList:V1")
  result.ISteamApps.methods.add("GetAppList:V2")
  result.ISteamApps.methods.add("GetSDRConfig:V1")
  result.ISteamApps.methods.add("GetServersAtAddress:V1")
  result.ISteamApps.methods.add("UpToDateCheck:V1")
  result.ISteamBroadcast.name = "ISteamBroadcast"
  result.ISteamBroadcast.methods.add("ViewerHeartbeat:V1")
  result.ISteamCDN.name = "ISteamCDN"
  result.ISteamCDN.methods.add("SetClientFilters:V1")
  result.ISteamCDN.methods.add("SetPerformanceStats:V1")
  result.ISteamDirectory.name = "ISteamDirectory"
  result.ISteamDirectory.methods.add("GetCMList:V1")
  result.ISteamDirectory.methods.add("GetCMListForConnect:V1")
  result.ISteamDirectory.methods.add("GetSteamPipeDomains:V1")
  result.ISteamEconomy.name = "ISteamEconomy"
  result.ISteamEconomy.methods.add("GetAssetClassInfo:V1")
  result.ISteamEconomy.methods.add("GetAssetPrices:V1")
  result.ISteamNews.name = "ISteamNews"
  result.ISteamNews.methods.add("GetNewsForApp:V1")
  result.ISteamNews.methods.add("GetNewsForApp:V2")
  result.ISteamRemoteStorage.name = "ISteamRemoteStorage"
  result.ISteamRemoteStorage.methods.add("GetCollectionDetails:V1")
  result.ISteamRemoteStorage.methods.add("GetPublishedFileDetails:V1")
  result.ISteamRemoteStorage.methods.add("GetUGCFileDetails:V1")
  result.ISteamUser.name = "ISteamUser"
  result.ISteamUser.methods.add("GetFriendList:V1")
  result.ISteamUser.methods.add("GetPlayerBans:V1")
  result.ISteamUser.methods.add("GetPlayerSummaries:V1")
  result.ISteamUser.methods.add("GetPlayerSummaries:V2")
  result.ISteamUser.methods.add("GetUserGroupList:V1")
  result.ISteamUser.methods.add("ResolveVanityURL:V1")
  result.ISteamUserAuth.name = "ISteamUserAuth"
  result.ISteamUserAuth.methods.add("AuthenticateUser:V1")
  result.ISteamUserAuth.methods.add("AuthenticateUserTicket:V1")
  result.ISteamUserOAuth.name = "ISteamUserOAuth"
  result.ISteamUserOAuth.methods.add("GetTokenDetails:V1")
  result.ISteamUserStats.name = "ISteamUserStats"
  result.ISteamUserStats.methods.add("GetGlobalAchievementPercentagesForApp:V1")
  result.ISteamUserStats.methods.add("GetGlobalAchievementPercentagesForApp:V2")
  result.ISteamUserStats.methods.add("GetGlobalStatsForGame:V1")
  result.ISteamUserStats.methods.add("GetNumberOfCurrentPlayers:V1")
  result.ISteamUserStats.methods.add("GetPlayerAchievements:V1")
  result.ISteamUserStats.methods.add("GetSchemaForGame:V1")
  result.ISteamUserStats.methods.add("GetSchemaForGame:V2")
  result.ISteamUserStats.methods.add("GetUserStatsForGame:V1")
  result.ISteamUserStats.methods.add("GetUserStatsForGame:V2")
  result.ISteamWebAPIUtil.name = "ISteamWebAPIUtil"
  result.ISteamWebAPIUtil.methods.add("GetServerInfo:V1")
  result.ISteamWebAPIUtil.methods.add("GetSupportedAPIList:V1")
  result.ISteamWebUserPresenceOAuth.name = "ISteamWebUserPresenceOAuth"
  result.ISteamWebUserPresenceOAuth.methods.add("PollStatus:V1")
  result.ITFItems_440.name = "ITFItems_440"
  result.ITFItems_440.methods.add("GetGoldenWrenches:V1")
  result.ITFItems_440.methods.add("GetGoldenWrenches:V2")
  result.ITFPromos_205790.name = "ITFPromos_205790"
  result.ITFPromos_205790.methods.add("GetItemID:V1")
  result.ITFPromos_205790.methods.add("GrantItem:V1")
  result.ITFPromos_440.name = "ITFPromos_440"
  result.ITFPromos_440.methods.add("GetItemID:V1")
  result.ITFPromos_440.methods.add("GrantItem:V1")
  result.ITFPromos_620.name = "ITFPromos_620"
  result.ITFPromos_620.methods.add("GetItemID:V1")
  result.ITFPromos_620.methods.add("GrantItem:V1")
  result.ITFSystem_440.name = "ITFSystem_440"
  result.ITFSystem_440.methods.add("GetWorldStatus:V1")
  result.IGameServersService.name = "IGameServersService"
  result.IGameServersService.methods.add("GetAccountList:V1")
  result.IGameServersService.methods.add("CreateAccount:V1")
  result.IGameServersService.methods.add("SetMemo:V1")
  result.IGameServersService.methods.add("ResetLoginToken:V1")
  result.IGameServersService.methods.add("DeleteAccount:V1")
  result.IGameServersService.methods.add("GetAccountPublicInfo:V1")
  result.IGameServersService.methods.add("QueryLoginToken:V1")
  result.IGameServersService.methods.add("GetServerSteamIDsByIP:V1")
  result.IGameServersService.methods.add("GetServerIPsBySteamID:V1")
  result.IGameServersService.methods.add("QueryByFakeIP:V1")
  result.IPlayerService.name = "IPlayerService"
  result.IPlayerService.methods.add("IsPlayingSharedGame:V1")
  result.IPlayerService.methods.add("RecordOfflinePlaytime:V1")
  result.IPlayerService.methods.add("GetRecentlyPlayedGames:V1")
  result.IPlayerService.methods.add("GetOwnedGames:V1")
  result.IPlayerService.methods.add("GetSteamLevel:V1")
  result.IPlayerService.methods.add("GetBadges:V1")
  result.IPlayerService.methods.add("GetCommunityBadgeProgress:V1")
  result.IBroadcastService.name = "IBroadcastService"
  result.IBroadcastService.methods.add("PostGameDataFrameRTMP:V1")
  result.IContentServerConfigService.name = "IContentServerConfigService"
  result.IContentServerConfigService.methods.add("SetSteamCacheClientFilters:V1")
  result.IContentServerConfigService.methods.add("GetSteamCacheNodeParams:V1")
  result.IContentServerConfigService.methods.add("SetSteamCachePerformanceStats:V1")
  result.IContentServerDirectoryService.name = "IContentServerDirectoryService"
  result.IContentServerDirectoryService.methods.add("GetServersForSteamPipe:V1")
  result.IContentServerDirectoryService.methods.add("GetClientUpdateHosts:V1")
  result.IContentServerDirectoryService.methods.add("GetDepotPatchInfo:V1")
  result.IPublishedFileService.name = "IPublishedFileService"
  result.IPublishedFileService.methods.add("GetUserVoteSummary:V1")
  result.IPublishedFileService.methods.add("QueryFiles:V1")
  result.IPublishedFileService.methods.add("GetDetails:V1")
  result.IPublishedFileService.methods.add("GetUserFiles:V1")
  result.IEconService.name = "IEconService"
  result.IEconService.methods.add("GetTradeHistory:V1")
  result.IEconService.methods.add("GetTradeStatus:V1")
  result.IEconService.methods.add("GetTradeOffers:V1")
  result.IEconService.methods.add("GetTradeOffer:V1")
  result.IEconService.methods.add("GetTradeOffersSummary:V1")
  result.IEconService.methods.add("GetTradeHoldDurations:V1")
  result.IGameNotificationsService.name = "IGameNotificationsService"
  result.IGameNotificationsService.methods.add("UserCreateSession:V1")
  result.IGameNotificationsService.methods.add("UserUpdateSession:V1")
  result.IGameNotificationsService.methods.add("UserDeleteSession:V1")
  result.IInventoryService.name = "IInventoryService"
  result.IInventoryService.methods.add("SplitItemStack:V1")
  result.IInventoryService.methods.add("CombineItemStacks:V1")
  result.IInventoryService.methods.add("GetPriceSheet:V1")
  result.IStoreService.name = "IStoreService"
  result.IStoreService.methods.add("GetAppList:V1")
  result.ICheatReportingService.name = "ICheatReportingService"
  result.ICheatReportingService.methods.add("ReportCheatData:V1")
  return result


proc newParam(name:string, value:string):Param=
  result.name=name
  result.value=value

proc prm2get(s:seq[Param]):string =
  if s.len>0:
    for i in countup(0,s.len-1):
      result.add((if i==0:"?"else:"&")&s[i].name&"="&encodeUrl(s[i].value))

proc prm2post(s:seq[Param]):string=
  if s.len>0:
    for i in countup(0,s.len-1):
      result.add((if i==0:""else:"&")&s[i].name&"="&encodeUrl(s[i].value)) 

proc `ReportEventV1`*(interfacename: IClientStats_1046930): string = 
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/ReportEvent/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url) 

proc `GetNextMatchSharingCodeV1`*(interfacename: ICSGOPlayers_730, `steamid`=none(uint64), `steamidkey`=none(string), `knowncode`=none(string)): string = 
  ## `steamid` : uint64 — (Required) The SteamID of the user
  ## `steamidkey` : string — (Required) Authentication obtained from the SteamID
  ## `knowncode` : string — (Required) Previously known match sharing code obtained from the SteamID
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `steamidkey`.isSome(): 
    params.add(newParam("steamidkey", $steamidkey))
  if `knowncode`.isSome(): 
    params.add(newParam("knowncode", $knowncode))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNextMatchSharingCode/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGameMapsPlaytimeV1`*(interfacename: ICSGOServers_730, `interval`=none(string), `gamemode`=none(string), `mapgroup`=none(string)): string = 
  ## `interval` : string — (Required) What recent interval is requested, possible values: day, week, month
  ## `gamemode` : string — (Required) What game mode is requested, possible values: competitive, casual
  ## `mapgroup` : string — (Required) What maps are requested, possible values: operation
  var params: seq[Param]
  if `interval`.isSome(): 
    params.add(newParam("interval", $interval))
  if `gamemode`.isSome(): 
    params.add(newParam("gamemode", $gamemode))
  if `mapgroup`.isSome(): 
    params.add(newParam("mapgroup", $mapgroup))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameMapsPlaytime/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGameServersStatusV1`*(interfacename: ICSGOServers_730): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameServersStatus/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentFantasyLineupV1`*(interfacename: ICSGOTournaments_730, `event`=none(uint32), `steamid`=none(uint64), `steamidkey`=none(string)): string = 
  ## `event` : uint32 — (Required) The event ID
  ## `steamid` : uint64 — (Required) The SteamID of the user inventory
  ## `steamidkey` : string — (Required) Authentication obtained from the SteamID
  var params: seq[Param]
  if `event`.isSome(): 
    params.add(newParam("event", $event))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `steamidkey`.isSome(): 
    params.add(newParam("steamidkey", $steamidkey))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentFantasyLineup/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentItemsV1`*(interfacename: ICSGOTournaments_730, `event`=none(uint32), `steamid`=none(uint64), `steamidkey`=none(string)): string = 
  ## `event` : uint32 — (Required) The event ID
  ## `steamid` : uint64 — (Required) The SteamID of the user inventory
  ## `steamidkey` : string — (Required) Authentication obtained from the SteamID
  var params: seq[Param]
  if `event`.isSome(): 
    params.add(newParam("event", $event))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `steamidkey`.isSome(): 
    params.add(newParam("steamidkey", $steamidkey))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentLayoutV1`*(interfacename: ICSGOTournaments_730, `event`=none(uint32)): string = 
  ## `event` : uint32 — (Required) The event ID
  var params: seq[Param]
  if `event`.isSome(): 
    params.add(newParam("event", $event))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentLayout/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentPredictionsV1`*(interfacename: ICSGOTournaments_730, `event`=none(uint32), `steamid`=none(uint64), `steamidkey`=none(string)): string = 
  ## `event` : uint32 — (Required) The event ID
  ## `steamid` : uint64 — (Required) The SteamID of the user inventory
  ## `steamidkey` : string — (Required) Authentication obtained from the SteamID
  var params: seq[Param]
  if `event`.isSome(): 
    params.add(newParam("event", $event))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `steamidkey`.isSome(): 
    params.add(newParam("steamidkey", $steamidkey))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPredictions/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `UploadTournamentFantasyLineupV1`*(interfacename: ICSGOTournaments_730, `event`=none(uint32), `steamid`=none(uint64), `steamidkey`=none(string), `sectionid`=none(uint32), `pickid0`=none(uint32), `itemid0`=none(uint64), `pickid1`=none(uint32), `itemid1`=none(uint64), `pickid2`=none(uint32), `itemid2`=none(uint64), `pickid3`=none(uint32), `itemid3`=none(uint64), `pickid4`=none(uint32), `itemid4`=none(uint64)): string = 
  ## `event` : uint32 — (Required) The event ID
  ## `steamid` : uint64 — (Required) The SteamID of the user inventory
  ## `steamidkey` : string — (Required) Authentication obtained from the SteamID
  ## `sectionid` : uint32 — (Required) Event section id
  ## `pickid0` : uint32 — (Required) PickID to select for the slot
  ## `itemid0` : uint64 — (Required) ItemID to lock in for the pick
  ## `pickid1` : uint32 — (Required) PickID to select for the slot
  ## `itemid1` : uint64 — (Required) ItemID to lock in for the pick
  ## `pickid2` : uint32 — (Required) PickID to select for the slot
  ## `itemid2` : uint64 — (Required) ItemID to lock in for the pick
  ## `pickid3` : uint32 — (Required) PickID to select for the slot
  ## `itemid3` : uint64 — (Required) ItemID to lock in for the pick
  ## `pickid4` : uint32 — (Required) PickID to select for the slot
  ## `itemid4` : uint64 — (Required) ItemID to lock in for the pick
  var params: seq[Param]
  if `event`.isSome(): 
    params.add(newParam("event", $event))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `steamidkey`.isSome(): 
    params.add(newParam("steamidkey", $steamidkey))
  if `sectionid`.isSome(): 
    params.add(newParam("sectionid", $sectionid))
  if `pickid0`.isSome(): 
    params.add(newParam("pickid0", $pickid0))
  if `itemid0`.isSome(): 
    params.add(newParam("itemid0", $itemid0))
  if `pickid1`.isSome(): 
    params.add(newParam("pickid1", $pickid1))
  if `itemid1`.isSome(): 
    params.add(newParam("itemid1", $itemid1))
  if `pickid2`.isSome(): 
    params.add(newParam("pickid2", $pickid2))
  if `itemid2`.isSome(): 
    params.add(newParam("itemid2", $itemid2))
  if `pickid3`.isSome(): 
    params.add(newParam("pickid3", $pickid3))
  if `itemid3`.isSome(): 
    params.add(newParam("itemid3", $itemid3))
  if `pickid4`.isSome(): 
    params.add(newParam("pickid4", $pickid4))
  if `itemid4`.isSome(): 
    params.add(newParam("itemid4", $itemid4))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UploadTournamentFantasyLineup/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `UploadTournamentPredictionsV1`*(interfacename: ICSGOTournaments_730, `event`=none(uint32), `steamid`=none(uint64), `steamidkey`=none(string), `sectionid`=none(uint32), `groupid`=none(uint32), `index`=none(uint32), `pickid`=none(uint32), `itemid`=none(uint64)): string = 
  ## `event` : uint32 — (Required) The event ID
  ## `steamid` : uint64 — (Required) The SteamID of the user inventory
  ## `steamidkey` : string — (Required) Authentication obtained from the SteamID
  ## `sectionid` : uint32 — (Required) Event section id
  ## `groupid` : uint32 — (Required) Event group id
  ## `index` : uint32 — (Required) Index in group
  ## `pickid` : uint32 — (Required) Pick ID to select
  ## `itemid` : uint64 — (Required) ItemID to lock in for the pick
  var params: seq[Param]
  if `event`.isSome(): 
    params.add(newParam("event", $event))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `steamidkey`.isSome(): 
    params.add(newParam("steamidkey", $steamidkey))
  if `sectionid`.isSome(): 
    params.add(newParam("sectionid", $sectionid))
  if `groupid`.isSome(): 
    params.add(newParam("groupid", $groupid))
  if `index`.isSome(): 
    params.add(newParam("index", $index))
  if `pickid`.isSome(): 
    params.add(newParam("pickid", $pickid))
  if `itemid`.isSome(): 
    params.add(newParam("itemid", $itemid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UploadTournamentPredictions/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `GetFantasyPlayerStatsV1`*(interfacename: IDOTA2Fantasy_205790, `FantasyLeagueID`=none(uint32), `StartTime`=none(uint32), `EndTime`=none(uint32), `MatchID`=none(uint64), `SeriesID`=none(uint32), `PlayerAccountID`=none(uint32)): string = 
  ## `FantasyLeagueID` : uint32 — (Required) The fantasy league ID
  ## `StartTime` : uint32 — (Optional) An optional filter for minimum timestamp
  ## `EndTime` : uint32 — (Optional) An optional filter for maximum timestamp
  ## `MatchID` : uint64 — (Optional) An optional filter for a specific match
  ## `SeriesID` : uint32 — (Optional) An optional filter for a specific series
  ## `PlayerAccountID` : uint32 — (Optional) An optional filter for a specific player
  var params: seq[Param]
  if `FantasyLeagueID`.isSome(): 
    params.add(newParam("FantasyLeagueID", $FantasyLeagueID))
  if `StartTime`.isSome(): 
    params.add(newParam("StartTime", $StartTime))
  if `EndTime`.isSome(): 
    params.add(newParam("EndTime", $EndTime))
  if `MatchID`.isSome(): 
    params.add(newParam("MatchID", $MatchID))
  if `SeriesID`.isSome(): 
    params.add(newParam("SeriesID", $SeriesID))
  if `PlayerAccountID`.isSome(): 
    params.add(newParam("PlayerAccountID", $PlayerAccountID))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetFantasyPlayerStats/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerOfficialInfoV1`*(interfacename: IDOTA2Fantasy_205790, `accountid`=none(uint32)): string = 
  ## `accountid` : uint32 — (Required) The account ID to look up
  var params: seq[Param]
  if `accountid`.isSome(): 
    params.add(newParam("accountid", $accountid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerOfficialInfo/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetProPlayerListV1`*(interfacename: IDOTA2Fantasy_205790): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetProPlayerList/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetRealtimeStatsV1`*(interfacename: IDOTA2MatchStats_205790, `server_steam_id`=none(uint64)): string = 
  ## `server_steam_id` : uint64 — (Required) 
  var params: seq[Param]
  if `server_steam_id`.isSome(): 
    params.add(newParam("server_steam_id", $server_steam_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRealtimeStats/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetRealtimeStatsV1`*(interfacename: IDOTA2MatchStats_570, `server_steam_id`=none(uint64)): string = 
  ## `server_steam_id` : uint64 — (Required) 
  var params: seq[Param]
  if `server_steam_id`.isSome(): 
    params.add(newParam("server_steam_id", $server_steam_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRealtimeStats/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetLeagueListingV1`*(interfacename: IDOTA2Match_205790): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetLeagueListing/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetLiveLeagueGamesV1`*(interfacename: IDOTA2Match_205790, `league_id`=none(uint32), `match_id`=none(uint64)): string = 
  ## `league_id` : uint32 — (Optional) Only show matches of the specified league id
  ## `match_id` : uint64 — (Optional) Only show matches of the specified match id
  var params: seq[Param]
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetLiveLeagueGames/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetMatchDetailsV1`*(interfacename: IDOTA2Match_205790, `match_id`=none(uint64)): string = 
  ## `match_id` : uint64 — (Required) Match id
  var params: seq[Param]
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchDetails/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetMatchHistoryV1`*(interfacename: IDOTA2Match_205790, `hero_id`=none(uint32), `game_mode`=none(uint32), `skill`=none(uint32), `min_players`=none(string), `account_id`=none(string), `league_id`=none(string), `start_at_match_id`=none(uint64), `matches_requested`=none(string)): string = 
  ## `hero_id` : uint32 — (Optional) The ID of the hero that must be in the matches being queried
  ## `game_mode` : uint32 — (Optional) Which game mode to return matches for
  ## `skill` : uint32 — (Optional) The average skill range of the match, these can be [1-3] with lower numbers being lower skill. Ignored if an account ID is specified
  ## `min_players` : string — (Optional) Minimum number of human players that must be in a match for it to be returned
  ## `account_id` : string — (Optional) An account ID to get matches from. This will fail if the user has their match history hidden
  ## `league_id` : string — (Optional) The league ID to return games from
  ## `start_at_match_id` : uint64 — (Optional) The minimum match ID to start from
  ## `matches_requested` : string — (Optional) The number of requested matches to return
  var params: seq[Param]
  if `hero_id`.isSome(): 
    params.add(newParam("hero_id", $hero_id))
  if `game_mode`.isSome(): 
    params.add(newParam("game_mode", $game_mode))
  if `skill`.isSome(): 
    params.add(newParam("skill", $skill))
  if `min_players`.isSome(): 
    params.add(newParam("min_players", $min_players))
  if `account_id`.isSome(): 
    params.add(newParam("account_id", $account_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `start_at_match_id`.isSome(): 
    params.add(newParam("start_at_match_id", $start_at_match_id))
  if `matches_requested`.isSome(): 
    params.add(newParam("matches_requested", $matches_requested))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistory/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetMatchHistoryBySequenceNumV1`*(interfacename: IDOTA2Match_205790, `start_at_match_seq_num`=none(uint64), `matches_requested`=none(uint32)): string = 
  ## `start_at_match_seq_num` : uint64 — (Optional) 
  ## `matches_requested` : uint32 — (Optional) 
  var params: seq[Param]
  if `start_at_match_seq_num`.isSome(): 
    params.add(newParam("start_at_match_seq_num", $start_at_match_seq_num))
  if `matches_requested`.isSome(): 
    params.add(newParam("matches_requested", $matches_requested))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistoryBySequenceNum/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTeamInfoByTeamIDV1`*(interfacename: IDOTA2Match_205790, `start_at_team_id`=none(uint64), `teams_requested`=none(uint32)): string = 
  ## `start_at_team_id` : uint64 — (Optional) 
  ## `teams_requested` : uint32 — (Optional) 
  var params: seq[Param]
  if `start_at_team_id`.isSome(): 
    params.add(newParam("start_at_team_id", $start_at_team_id))
  if `teams_requested`.isSome(): 
    params.add(newParam("teams_requested", $teams_requested))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTeamInfoByTeamID/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTopLiveEventGameV1`*(interfacename: IDOTA2Match_205790, `partner`=none(int32)): string = 
  ## `partner` : int32 — (Required) Which partner's games to use.
  var params: seq[Param]
  if `partner`.isSome(): 
    params.add(newParam("partner", $partner))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveEventGame/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTopLiveGameV1`*(interfacename: IDOTA2Match_205790, `partner`=none(int32)): string = 
  ## `partner` : int32 — (Required) Which partner's games to use.
  var params: seq[Param]
  if `partner`.isSome(): 
    params.add(newParam("partner", $partner))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveGame/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTopWeekendTourneyGamesV1`*(interfacename: IDOTA2Match_205790, `partner`=none(int32), `home_division`=none(int32)): string = 
  ## `partner` : int32 — (Required) Which partner's games to use.
  ## `home_division` : int32 — (Optional) Prefer matches from this division.
  var params: seq[Param]
  if `partner`.isSome(): 
    params.add(newParam("partner", $partner))
  if `home_division`.isSome(): 
    params.add(newParam("home_division", $home_division))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopWeekendTourneyGames/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentPlayerStatsV1`*(interfacename: IDOTA2Match_205790, `account_id`=none(string), `league_id`=none(string), `hero_id`=none(string), `time_frame`=none(string), `match_id`=none(uint64), `phase_id`=none(uint32)): string = 
  ## `account_id` : string — (Required) 
  ## `league_id` : string — (Optional) 
  ## `hero_id` : string — (Optional) 
  ## `time_frame` : string — (Optional) 
  ## `match_id` : uint64 — (Optional) 
  ## `phase_id` : uint32 — (Optional) 
  var params: seq[Param]
  if `account_id`.isSome(): 
    params.add(newParam("account_id", $account_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `hero_id`.isSome(): 
    params.add(newParam("hero_id", $hero_id))
  if `time_frame`.isSome(): 
    params.add(newParam("time_frame", $time_frame))
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  if `phase_id`.isSome(): 
    params.add(newParam("phase_id", $phase_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentPlayerStatsV2`*(interfacename: IDOTA2Match_205790, `account_id`=none(string), `league_id`=none(string), `hero_id`=none(string), `time_frame`=none(string), `match_id`=none(uint64), `phase_id`=none(uint32)): string = 
  ## `account_id` : string — (Required) 
  ## `league_id` : string — (Optional) 
  ## `hero_id` : string — (Optional) 
  ## `time_frame` : string — (Optional) 
  ## `match_id` : uint64 — (Optional) 
  ## `phase_id` : uint32 — (Optional) 
  var params: seq[Param]
  if `account_id`.isSome(): 
    params.add(newParam("account_id", $account_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `hero_id`.isSome(): 
    params.add(newParam("hero_id", $hero_id))
  if `time_frame`.isSome(): 
    params.add(newParam("time_frame", $time_frame))
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  if `phase_id`.isSome(): 
    params.add(newParam("phase_id", $phase_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v2/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetLiveLeagueGamesV1`*(interfacename: IDOTA2Match_570, `league_id`=none(uint32), `match_id`=none(uint64), `dpc`=none(bool)): string = 
  ## `league_id` : uint32 — (Optional) Only show matches of the specified league id
  ## `match_id` : uint64 — (Optional) Only show matches of the specified match id
  ## `dpc` : bool — (Optional) Only show matches that are part of the DPC
  var params: seq[Param]
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  if `dpc`.isSome(): 
    params.add(newParam("dpc", $dpc))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetLiveLeagueGames/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetMatchDetailsV1`*(interfacename: IDOTA2Match_570, `match_id`=none(uint64), `include_persona_names`=none(bool)): string = 
  ## `match_id` : uint64 — (Required) Match id
  ## `include_persona_names` : bool — (Optional) Include persona names as part of the response
  var params: seq[Param]
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  if `include_persona_names`.isSome(): 
    params.add(newParam("include_persona_names", $include_persona_names))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchDetails/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetMatchHistoryV1`*(interfacename: IDOTA2Match_570, `hero_id`=none(uint32), `game_mode`=none(uint32), `skill`=none(uint32), `min_players`=none(string), `account_id`=none(string), `league_id`=none(string), `start_at_match_id`=none(uint64), `matches_requested`=none(string)): string = 
  ## `hero_id` : uint32 — (Optional) The ID of the hero that must be in the matches being queried
  ## `game_mode` : uint32 — (Optional) Which game mode to return matches for
  ## `skill` : uint32 — (Optional) The average skill range of the match, these can be [1-3] with lower numbers being lower skill. Ignored if an account ID is specified
  ## `min_players` : string — (Optional) Minimum number of human players that must be in a match for it to be returned
  ## `account_id` : string — (Optional) An account ID to get matches from. This will fail if the user has their match history hidden
  ## `league_id` : string — (Optional) The league ID to return games from
  ## `start_at_match_id` : uint64 — (Optional) The minimum match ID to start from
  ## `matches_requested` : string — (Optional) The number of requested matches to return
  var params: seq[Param]
  if `hero_id`.isSome(): 
    params.add(newParam("hero_id", $hero_id))
  if `game_mode`.isSome(): 
    params.add(newParam("game_mode", $game_mode))
  if `skill`.isSome(): 
    params.add(newParam("skill", $skill))
  if `min_players`.isSome(): 
    params.add(newParam("min_players", $min_players))
  if `account_id`.isSome(): 
    params.add(newParam("account_id", $account_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `start_at_match_id`.isSome(): 
    params.add(newParam("start_at_match_id", $start_at_match_id))
  if `matches_requested`.isSome(): 
    params.add(newParam("matches_requested", $matches_requested))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistory/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetMatchHistoryBySequenceNumV1`*(interfacename: IDOTA2Match_570, `start_at_match_seq_num`=none(uint64), `matches_requested`=none(uint32)): string = 
  ## `start_at_match_seq_num` : uint64 — (Optional) 
  ## `matches_requested` : uint32 — (Optional) 
  var params: seq[Param]
  if `start_at_match_seq_num`.isSome(): 
    params.add(newParam("start_at_match_seq_num", $start_at_match_seq_num))
  if `matches_requested`.isSome(): 
    params.add(newParam("matches_requested", $matches_requested))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistoryBySequenceNum/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTeamInfoByTeamIDV1`*(interfacename: IDOTA2Match_570, `start_at_team_id`=none(uint64), `teams_requested`=none(uint32)): string = 
  ## `start_at_team_id` : uint64 — (Optional) 
  ## `teams_requested` : uint32 — (Optional) 
  var params: seq[Param]
  if `start_at_team_id`.isSome(): 
    params.add(newParam("start_at_team_id", $start_at_team_id))
  if `teams_requested`.isSome(): 
    params.add(newParam("teams_requested", $teams_requested))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTeamInfoByTeamID/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTopLiveEventGameV1`*(interfacename: IDOTA2Match_570, `partner`=none(int32)): string = 
  ## `partner` : int32 — (Required) Which partner's games to use.
  var params: seq[Param]
  if `partner`.isSome(): 
    params.add(newParam("partner", $partner))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveEventGame/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTopLiveGameV1`*(interfacename: IDOTA2Match_570, `partner`=none(int32)): string = 
  ## `partner` : int32 — (Required) Which partner's games to use.
  var params: seq[Param]
  if `partner`.isSome(): 
    params.add(newParam("partner", $partner))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveGame/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTopWeekendTourneyGamesV1`*(interfacename: IDOTA2Match_570, `partner`=none(int32), `home_division`=none(int32)): string = 
  ## `partner` : int32 — (Required) Which partner's games to use.
  ## `home_division` : int32 — (Optional) Prefer matches from this division.
  var params: seq[Param]
  if `partner`.isSome(): 
    params.add(newParam("partner", $partner))
  if `home_division`.isSome(): 
    params.add(newParam("home_division", $home_division))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopWeekendTourneyGames/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentPlayerStatsV1`*(interfacename: IDOTA2Match_570, `account_id`=none(string), `league_id`=none(string), `hero_id`=none(string), `time_frame`=none(string), `match_id`=none(uint64)): string = 
  ## `account_id` : string — (Required) 
  ## `league_id` : string — (Optional) 
  ## `hero_id` : string — (Optional) 
  ## `time_frame` : string — (Optional) 
  ## `match_id` : uint64 — (Optional) 
  var params: seq[Param]
  if `account_id`.isSome(): 
    params.add(newParam("account_id", $account_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `hero_id`.isSome(): 
    params.add(newParam("hero_id", $hero_id))
  if `time_frame`.isSome(): 
    params.add(newParam("time_frame", $time_frame))
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentPlayerStatsV2`*(interfacename: IDOTA2Match_570, `account_id`=none(string), `league_id`=none(string), `hero_id`=none(string), `time_frame`=none(string), `match_id`=none(uint64), `phase_id`=none(uint32)): string = 
  ## `account_id` : string — (Required) 
  ## `league_id` : string — (Optional) 
  ## `hero_id` : string — (Optional) 
  ## `time_frame` : string — (Optional) 
  ## `match_id` : uint64 — (Optional) 
  ## `phase_id` : uint32 — (Optional) 
  var params: seq[Param]
  if `account_id`.isSome(): 
    params.add(newParam("account_id", $account_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `hero_id`.isSome(): 
    params.add(newParam("hero_id", $hero_id))
  if `time_frame`.isSome(): 
    params.add(newParam("time_frame", $time_frame))
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  if `phase_id`.isSome(): 
    params.add(newParam("phase_id", $phase_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v2/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetBroadcasterInfoV1`*(interfacename: IDOTA2StreamSystem_205790, `broadcaster_steam_id`=none(uint64), `league_id`=none(uint32)): string = 
  ## `broadcaster_steam_id` : uint64 — (Required) 64-bit Steam ID of the broadcaster
  ## `league_id` : uint32 — (Optional) LeagueID to use if we aren't in a lobby
  var params: seq[Param]
  if `broadcaster_steam_id`.isSome(): 
    params.add(newParam("broadcaster_steam_id", $broadcaster_steam_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBroadcasterInfo/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetBroadcasterInfoV1`*(interfacename: IDOTA2StreamSystem_570, `broadcaster_steam_id`=none(uint64), `league_id`=none(uint32)): string = 
  ## `broadcaster_steam_id` : uint64 — (Required) 64-bit Steam ID of the broadcaster
  ## `league_id` : uint32 — (Optional) LeagueID to use if we aren't in a lobby
  var params: seq[Param]
  if `broadcaster_steam_id`.isSome(): 
    params.add(newParam("broadcaster_steam_id", $broadcaster_steam_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBroadcasterInfo/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `ClaimBadgeRewardV1`*(interfacename: IDOTA2Ticket_205790, `BadgeID`=none(string), `ValidBadgeType1`=none(uint32), `ValidBadgeType2`=none(uint32), `ValidBadgeType3`=none(uint32)): string = 
  ## `BadgeID` : string — (Required) The Badge ID
  ## `ValidBadgeType1` : uint32 — (Required) Valid Badge Type 1
  ## `ValidBadgeType2` : uint32 — (Required) Valid Badge Type 2
  ## `ValidBadgeType3` : uint32 — (Required) Valid Badge Type 3
  var params: seq[Param]
  if `BadgeID`.isSome(): 
    params.add(newParam("BadgeID", $BadgeID))
  if `ValidBadgeType1`.isSome(): 
    params.add(newParam("ValidBadgeType1", $ValidBadgeType1))
  if `ValidBadgeType2`.isSome(): 
    params.add(newParam("ValidBadgeType2", $ValidBadgeType2))
  if `ValidBadgeType3`.isSome(): 
    params.add(newParam("ValidBadgeType3", $ValidBadgeType3))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/ClaimBadgeReward/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSteamIDForBadgeIDV1`*(interfacename: IDOTA2Ticket_205790, `BadgeID`=none(string)): string = 
  ## `BadgeID` : string — (Required) The badge ID
  var params: seq[Param]
  if `BadgeID`.isSome(): 
    params.add(newParam("BadgeID", $BadgeID))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamIDForBadgeID/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `SetSteamAccountPurchasedV1`*(interfacename: IDOTA2Ticket_205790, `steamid`=none(uint64), `BadgeType`=none(uint32)): string = 
  ## `steamid` : uint64 — (Required) The 64-bit Steam ID
  ## `BadgeType` : uint32 — (Required) Badge Type
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `BadgeType`.isSome(): 
    params.add(newParam("BadgeType", $BadgeType))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamAccountPurchased/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `SteamAccountValidForBadgeTypeV1`*(interfacename: IDOTA2Ticket_205790, `steamid`=none(uint64), `ValidBadgeType1`=none(uint32), `ValidBadgeType2`=none(uint32), `ValidBadgeType3`=none(uint32)): string = 
  ## `steamid` : uint64 — (Required) The 64-bit Steam ID
  ## `ValidBadgeType1` : uint32 — (Required) Valid Badge Type 1
  ## `ValidBadgeType2` : uint32 — (Required) Valid Badge Type 2
  ## `ValidBadgeType3` : uint32 — (Required) Valid Badge Type 3
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `ValidBadgeType1`.isSome(): 
    params.add(newParam("ValidBadgeType1", $ValidBadgeType1))
  if `ValidBadgeType2`.isSome(): 
    params.add(newParam("ValidBadgeType2", $ValidBadgeType2))
  if `ValidBadgeType3`.isSome(): 
    params.add(newParam("ValidBadgeType3", $ValidBadgeType3))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/SteamAccountValidForBadgeType/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `SetSteamAccountPurchasedV1`*(interfacename: IDOTA2Ticket_570, `SteamID`=none(uint64), `BadgeType`=none(uint32)): string = 
  ## `SteamID` : uint64 — (Required) The 64-bit Steam ID
  ## `BadgeType` : uint32 — (Required) Badge Type
  var params: seq[Param]
  if `SteamID`.isSome(): 
    params.add(newParam("SteamID", $SteamID))
  if `BadgeType`.isSome(): 
    params.add(newParam("BadgeType", $BadgeType))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamAccountPurchased/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `SteamAccountValidForBadgeTypeV1`*(interfacename: IDOTA2Ticket_570, `SteamID`=none(uint64), `ValidBadgeType1`=none(uint32), `ValidBadgeType2`=none(uint32), `ValidBadgeType3`=none(uint32)): string = 
  ## `SteamID` : uint64 — (Required) The 64-bit Steam ID
  ## `ValidBadgeType1` : uint32 — (Required) Valid Badge Type 1
  ## `ValidBadgeType2` : uint32 — (Required) Valid Badge Type 2
  ## `ValidBadgeType3` : uint32 — (Required) Valid Badge Type 3
  var params: seq[Param]
  if `SteamID`.isSome(): 
    params.add(newParam("SteamID", $SteamID))
  if `ValidBadgeType1`.isSome(): 
    params.add(newParam("ValidBadgeType1", $ValidBadgeType1))
  if `ValidBadgeType2`.isSome(): 
    params.add(newParam("ValidBadgeType2", $ValidBadgeType2))
  if `ValidBadgeType3`.isSome(): 
    params.add(newParam("ValidBadgeType3", $ValidBadgeType3))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/SteamAccountValidForBadgeType/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetEventStatsForAccountV1`*(interfacename: IEconDOTA2_205790, `eventid`=none(uint32), `accountid`=none(uint32), `language`=none(string)): string = 
  ## `eventid` : uint32 — (Required) The League ID of the compendium you're looking for.
  ## `accountid` : uint32 — (Required) The account ID to look up.
  ## `language` : string — (Optional) The language to provide hero names in.
  var params: seq[Param]
  if `eventid`.isSome(): 
    params.add(newParam("eventid", $eventid))
  if `accountid`.isSome(): 
    params.add(newParam("accountid", $accountid))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEventStatsForAccount/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGameItemsV1`*(interfacename: IEconDOTA2_205790, `language`=none(string)): string = 
  ## `language` : string — (Optional) The language to provide item names in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetHeroesV1`*(interfacename: IEconDOTA2_205790, `language`=none(string), `itemizedonly`=none(bool)): string = 
  ## `language` : string — (Optional) The language to provide hero names in.
  ## `itemizedonly` : bool — (Optional) Return a list of itemized heroes only.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `itemizedonly`.isSome(): 
    params.add(newParam("itemizedonly", $itemizedonly))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetHeroes/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetItemIconPathV1`*(interfacename: IEconDOTA2_205790, `iconname`=none(string), `icontype`=none(uint32)): string = 
  ## `iconname` : string — (Required) The item icon name to get the CDN path of
  ## `icontype` : uint32 — (Optional) The type of image you want. 0 = normal, 1 = large, 2 = ingame
  var params: seq[Param]
  if `iconname`.isSome(): 
    params.add(newParam("iconname", $iconname))
  if `icontype`.isSome(): 
    params.add(newParam("icontype", $icontype))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemIconPath/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetRaritiesV1`*(interfacename: IEconDOTA2_205790, `language`=none(string)): string = 
  ## `language` : string — (Optional) The language to provide rarity names in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRarities/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentPrizePoolV1`*(interfacename: IEconDOTA2_205790, `leagueid`=none(uint32)): string = 
  ## `leagueid` : uint32 — (Optional) The ID of the league to get the prize pool of
  var params: seq[Param]
  if `leagueid`.isSome(): 
    params.add(newParam("leagueid", $leagueid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPrizePool/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetEventStatsForAccountV1`*(interfacename: IEconDOTA2_570, `eventid`=none(uint32), `accountid`=none(uint32), `language`=none(string)): string = 
  ## `eventid` : uint32 — (Required) The Event ID of the event you're looking for.
  ## `accountid` : uint32 — (Required) The account ID to look up.
  ## `language` : string — (Optional) The language to provide hero names in.
  var params: seq[Param]
  if `eventid`.isSome(): 
    params.add(newParam("eventid", $eventid))
  if `accountid`.isSome(): 
    params.add(newParam("accountid", $accountid))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEventStatsForAccount/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGameItemsV1`*(interfacename: IEconDOTA2_570, `language`=none(string)): string = 
  ## `language` : string — (Optional) The language to provide item names in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetHeroesV1`*(interfacename: IEconDOTA2_570, `language`=none(string), `itemizedonly`=none(bool)): string = 
  ## `language` : string — (Optional) The language to provide hero names in.
  ## `itemizedonly` : bool — (Optional) Return a list of itemized heroes only.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `itemizedonly`.isSome(): 
    params.add(newParam("itemizedonly", $itemizedonly))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetHeroes/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetItemCreatorsV1`*(interfacename: IEconDOTA2_570, `itemdef`=none(uint32)): string = 
  ## `itemdef` : uint32 — (Required) The item definition to get creator information for.
  var params: seq[Param]
  if `itemdef`.isSome(): 
    params.add(newParam("itemdef", $itemdef))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemCreators/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetItemWorkshopPublishedFileIDsV1`*(interfacename: IEconDOTA2_570, `itemdef`=none(uint32)): string = 
  ## `itemdef` : uint32 — (Required) The item definition to get published file ids for.
  var params: seq[Param]
  if `itemdef`.isSome(): 
    params.add(newParam("itemdef", $itemdef))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemWorkshopPublishedFileIDs/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetRaritiesV1`*(interfacename: IEconDOTA2_570, `language`=none(string)): string = 
  ## `language` : string — (Optional) The language to provide rarity names in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRarities/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentPrizePoolV1`*(interfacename: IEconDOTA2_570, `leagueid`=none(uint32)): string = 
  ## `leagueid` : uint32 — (Optional) The ID of the league to get the prize pool of
  var params: seq[Param]
  if `leagueid`.isSome(): 
    params.add(newParam("leagueid", $leagueid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPrizePool/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_1046930, `steamid`=none(uint64)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: IEconItems_1269260, `steamid`=none(uint64), `class_id`=none(uint32)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `class_id` : uint32 — (Required) Return items equipped for this class id
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `class_id`.isSome(): 
    params.add(newParam("class_id", $class_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: IEconItems_205790, `steamid`=none(uint64), `class_id`=none(uint32)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `class_id` : uint32 — (Required) Return items equipped for this class id
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `class_id`.isSome(): 
    params.add(newParam("class_id", $class_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_205790, `steamid`=none(uint64)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaURLV1`*(interfacename: IEconItems_205790): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaURL/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: IEconItems_205790, `language`=none(string)): string = 
  ## `language` : string — (Optional) The language to results in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_221540, `steamid`=none(uint64)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_238460, `steamid`=none(uint64)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_440, `steamid`=none(uint64)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaV1`*(interfacename: IEconItems_440, `language`=none(string)): string = 
  ## `language` : string — (Optional) The language to return the names in. Defaults to returning string keys.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchema/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaItemsV1`*(interfacename: IEconItems_440, `language`=none(string), `start`=none(int32)): string = 
  ## `language` : string — (Optional) The language to return the names in. Defaults to returning string keys.
  ## `start` : int32 — (Optional) The first item id to return. Defaults to 0. Response will indicate next value to query if applicable.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `start`.isSome(): 
    params.add(newParam("start", $start))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaOverviewV1`*(interfacename: IEconItems_440, `language`=none(string)): string = 
  ## `language` : string — (Optional) The language to return the names in. Defaults to returning string keys.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaOverview/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaURLV1`*(interfacename: IEconItems_440): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaURL/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: IEconItems_440, `language`=none(string)): string = 
  ## `language` : string — (Optional) The language to results in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetStoreStatusV1`*(interfacename: IEconItems_440): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreStatus/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: IEconItems_570, `SteamID`=none(uint64), `class_id`=none(uint32)): string = 
  ## `SteamID` : uint64 — (Required) The Steam ID to fetch items for
  ## `class_id` : uint32 — (Required) Return items equipped for this class id
  var params: seq[Param]
  if `SteamID`.isSome(): 
    params.add(newParam("SteamID", $SteamID))
  if `class_id`.isSome(): 
    params.add(newParam("class_id", $class_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_570, `SteamID`=none(uint64)): string = 
  ## `SteamID` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `SteamID`.isSome(): 
    params.add(newParam("SteamID", $SteamID))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: IEconItems_570, `language`=none(string)): string = 
  ## `language` : string — (Optional) The language to results in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: IEconItems_583950, `steamid`=none(uint64), `class_id`=none(uint32)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `class_id` : uint32 — (Required) Return items equipped for this class id
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `class_id`.isSome(): 
    params.add(newParam("class_id", $class_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_620, `steamid`=none(uint64)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaV1`*(interfacename: IEconItems_620, `language`=none(string)): string = 
  ## `language` : string — (Optional) The language to return the names in. Defaults to returning string keys.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchema/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_730, `steamid`=none(uint64)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaV2`*(interfacename: IEconItems_730, `language`=none(string)): string = 
  ## `language` : string — (Optional) The language to return the names in. Defaults to returning string keys.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchema/v2/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaURLV2`*(interfacename: IEconItems_730): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaURL/v2/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: IEconItems_730, `language`=none(string)): string = 
  ## `language` : string — (Optional) The language to results in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: IGCVersion_1046930): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: IGCVersion_1046930): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: IGCVersion_1269260): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: IGCVersion_1269260): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: IGCVersion_205790): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: IGCVersion_205790): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: IGCVersion_440): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: IGCVersion_440): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: IGCVersion_570): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: IGCVersion_570): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: IGCVersion_583950): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: IGCVersion_583950): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: IGCVersion_730): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetBucketizedDataV1`*(interfacename: IPortal2Leaderboards_620, `leaderboardName`=none(string)): string = 
  ## `leaderboardName` : string — (Required) The leaderboard name to fetch data for.
  var params: seq[Param]
  if `leaderboardName`.isSome(): 
    params.add(newParam("leaderboardName", $leaderboardName))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBucketizedData/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetAppListV1`*(interfacename: ISteamApps): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAppList/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetAppListV2`*(interfacename: ISteamApps): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAppList/v2/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSDRConfigV1`*(interfacename: ISteamApps, `appid`=none(uint32)): string = 
  ## `appid` : uint32 — (Required) AppID of game
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSDRConfig/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServersAtAddressV1`*(interfacename: ISteamApps, `addr`=none(string)): string = 
  ## `addr` : string — (Required) IP or IP:queryport to list
  var params: seq[Param]
  if `addr`.isSome(): 
    params.add(newParam("addr", $addr))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServersAtAddress/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `UpToDateCheckV1`*(interfacename: ISteamApps, `appid`=none(uint32), `version`=none(uint32)): string = 
  ## `appid` : uint32 — (Required) AppID of game
  ## `version` : uint32 — (Required) The installed version of the game
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `version`.isSome(): 
    params.add(newParam("version", $version))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/UpToDateCheck/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `ViewerHeartbeatV1`*(interfacename: ISteamBroadcast, `steamid`=none(uint64), `sessionid`=none(uint64), `token`=none(uint64), `stream`=none(int32)): string = 
  ## `steamid` : uint64 — (Required) Steam ID of the broadcaster
  ## `sessionid` : uint64 — (Required) Broadcast Session ID
  ## `token` : uint64 — (Required) Viewer token
  ## `stream` : int32 — (Optional) video stream representation watching
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `sessionid`.isSome(): 
    params.add(newParam("sessionid", $sessionid))
  if `token`.isSome(): 
    params.add(newParam("token", $token))
  if `stream`.isSome(): 
    params.add(newParam("stream", $stream))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/ViewerHeartbeat/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `SetClientFiltersV1`*(interfacename: ISteamCDN, `key`=none(string), `cdnname`=none(string), `allowedipblocks`=none(string), `allowedasns`=none(string), `allowedipcountries`=none(string)): string = 
  ## `key` : string — (Required) access key
  ## `cdnname` : string — (Required) Steam name of CDN property
  ## `allowedipblocks` : string — (Optional) comma-separated list of allowed IP address blocks in CIDR format - blank for not used
  ## `allowedasns` : string — (Optional) comma-separated list of allowed client network AS numbers - blank for not used
  ## `allowedipcountries` : string — (Optional) comma-separated list of allowed client IP country codes in ISO 3166-1 format - blank for not used
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `cdnname`.isSome(): 
    params.add(newParam("cdnname", $cdnname))
  if `allowedipblocks`.isSome(): 
    params.add(newParam("allowedipblocks", $allowedipblocks))
  if `allowedasns`.isSome(): 
    params.add(newParam("allowedasns", $allowedasns))
  if `allowedipcountries`.isSome(): 
    params.add(newParam("allowedipcountries", $allowedipcountries))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetClientFilters/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `SetPerformanceStatsV1`*(interfacename: ISteamCDN, `key`=none(string), `cdnname`=none(string), `mbps_sent`=none(uint32), `mbps_recv`=none(uint32), `cpu_percent`=none(uint32), `cache_hit_percent`=none(uint32)): string = 
  ## `key` : string — (Required) access key
  ## `cdnname` : string — (Required) Steam name of CDN property
  ## `mbps_sent` : uint32 — (Optional) Outgoing network traffic in Mbps
  ## `mbps_recv` : uint32 — (Optional) Incoming network traffic in Mbps
  ## `cpu_percent` : uint32 — (Optional) Percent CPU load
  ## `cache_hit_percent` : uint32 — (Optional) Percent cache hits
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `cdnname`.isSome(): 
    params.add(newParam("cdnname", $cdnname))
  if `mbps_sent`.isSome(): 
    params.add(newParam("mbps_sent", $mbps_sent))
  if `mbps_recv`.isSome(): 
    params.add(newParam("mbps_recv", $mbps_recv))
  if `cpu_percent`.isSome(): 
    params.add(newParam("cpu_percent", $cpu_percent))
  if `cache_hit_percent`.isSome(): 
    params.add(newParam("cache_hit_percent", $cache_hit_percent))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetPerformanceStats/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `GetCMListV1`*(interfacename: ISteamDirectory, `cellid`=none(uint32), `maxcount`=none(uint32)): string = 
  ## `cellid` : uint32 — (Required) Client's Steam cell ID
  ## `maxcount` : uint32 — (Optional) Max number of servers to return
  var params: seq[Param]
  if `cellid`.isSome(): 
    params.add(newParam("cellid", $cellid))
  if `maxcount`.isSome(): 
    params.add(newParam("maxcount", $maxcount))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCMList/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetCMListForConnectV1`*(interfacename: ISteamDirectory, `cellid`=none(uint32), `cmtype`=none(string), `realm`=none(string), `maxcount`=none(uint32)): string = 
  ## `cellid` : uint32 — (Optional) Client's Steam cell ID, uses IP location if blank
  ## `cmtype` : string — (Optional) Optional CM type filter
  ## `realm` : string — (Optional) Optional Steam Realm filter
  ## `maxcount` : uint32 — (Optional) Max number of servers to return
  var params: seq[Param]
  if `cellid`.isSome(): 
    params.add(newParam("cellid", $cellid))
  if `cmtype`.isSome(): 
    params.add(newParam("cmtype", $cmtype))
  if `realm`.isSome(): 
    params.add(newParam("realm", $realm))
  if `maxcount`.isSome(): 
    params.add(newParam("maxcount", $maxcount))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCMListForConnect/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSteamPipeDomainsV1`*(interfacename: ISteamDirectory): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamPipeDomains/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetAssetClassInfoV1`*(interfacename: ISteamEconomy, `appid`=none(uint32), `language`=none(string), `class_count`=none(uint32), `classid0`=none(uint64), `instanceid0`=none(uint64)): string = 
  ## `appid` : uint32 — (Required) Must be a steam economy app.
  ## `language` : string — (Optional) The user's local language
  ## `class_count` : uint32 — (Required) Number of classes requested. Must be at least one.
  ## `classid0` : uint64 — (Required) Class ID of the nth class.
  ## `instanceid0` : uint64 — (Optional) Instance ID of the nth class.
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `class_count`.isSome(): 
    params.add(newParam("class_count", $class_count))
  if `classid0`.isSome(): 
    params.add(newParam("classid0", $classid0))
  if `instanceid0`.isSome(): 
    params.add(newParam("instanceid0", $instanceid0))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAssetClassInfo/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetAssetPricesV1`*(interfacename: ISteamEconomy, `appid`=none(uint32), `currency`=none(string), `language`=none(string)): string = 
  ## `appid` : uint32 — (Required) Must be a steam economy app.
  ## `currency` : string — (Optional) The currency to filter for
  ## `language` : string — (Optional) The user's local language
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `currency`.isSome(): 
    params.add(newParam("currency", $currency))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAssetPrices/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetNewsForAppV1`*(interfacename: ISteamNews, `appid`=none(uint32), `maxlength`=none(uint32), `enddate`=none(uint32), `count`=none(uint32), `tags`=none(string)): string = 
  ## `appid` : uint32 — (Required) AppID to retrieve news for
  ## `maxlength` : uint32 — (Optional) Maximum length for the content to return, if this is 0 the full content is returned, if it's less then a blurb is generated to fit.
  ## `enddate` : uint32 — (Optional) Retrieve posts earlier than this date (unix epoch timestamp)
  ## `count` : uint32 — (Optional) # of posts to retrieve (default 20)
  ## `tags` : string — (Optional) Comma-separated list of tags to filter by (e.g. 'patchnodes')
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `maxlength`.isSome(): 
    params.add(newParam("maxlength", $maxlength))
  if `enddate`.isSome(): 
    params.add(newParam("enddate", $enddate))
  if `count`.isSome(): 
    params.add(newParam("count", $count))
  if `tags`.isSome(): 
    params.add(newParam("tags", $tags))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNewsForApp/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetNewsForAppV2`*(interfacename: ISteamNews, `appid`=none(uint32), `maxlength`=none(uint32), `enddate`=none(uint32), `count`=none(uint32), `feeds`=none(string), `tags`=none(string)): string = 
  ## `appid` : uint32 — (Required) AppID to retrieve news for
  ## `maxlength` : uint32 — (Optional) Maximum length for the content to return, if this is 0 the full content is returned, if it's less then a blurb is generated to fit.
  ## `enddate` : uint32 — (Optional) Retrieve posts earlier than this date (unix epoch timestamp)
  ## `count` : uint32 — (Optional) # of posts to retrieve (default 20)
  ## `feeds` : string — (Optional) Comma-separated list of feed names to return news for
  ## `tags` : string — (Optional) Comma-separated list of tags to filter by (e.g. 'patchnodes')
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `maxlength`.isSome(): 
    params.add(newParam("maxlength", $maxlength))
  if `enddate`.isSome(): 
    params.add(newParam("enddate", $enddate))
  if `count`.isSome(): 
    params.add(newParam("count", $count))
  if `feeds`.isSome(): 
    params.add(newParam("feeds", $feeds))
  if `tags`.isSome(): 
    params.add(newParam("tags", $tags))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNewsForApp/v2/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetCollectionDetailsV1`*(interfacename: ISteamRemoteStorage, `collectioncount`=none(uint32), `publishedfileids`=none(seq[uint64])): string = 
  ## `collectioncount` : uint32 — (Required) Number of collections being requested
  ## `publishedfileids[0]` : uint64 — (Required) collection ids to get the details for
  var params: seq[Param]
  if `collectioncount`.isSome(): 
    params.add(newParam("collectioncount", $collectioncount))
  if `publishedfileids`.isSome(): 
    ## Params for seq[]
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCollectionDetails/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `GetPublishedFileDetailsV1`*(interfacename: ISteamRemoteStorage, `itemcount`=none(uint32), `publishedfileids`=none(seq[uint64])): string = 
  ## `itemcount` : uint32 — (Required) Number of items being requested
  ## `publishedfileids[0]` : uint64 — (Required) published file id to look up
  var params: seq[Param]
  if `itemcount`.isSome(): 
    params.add(newParam("itemcount", $itemcount))
  if `publishedfileids`.isSome(): 
    ## Params for seq[]
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPublishedFileDetails/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `GetUGCFileDetailsV1`*(interfacename: ISteamRemoteStorage, `steamid`=none(uint64), `ugcid`=none(uint64), `appid`=none(uint32)): string = 
  ## `steamid` : uint64 — (Optional) If specified, only returns details if the file is owned by the SteamID specified
  ## `ugcid` : uint64 — (Required) ID of UGC file to get info for
  ## `appid` : uint32 — (Required) appID of product
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `ugcid`.isSome(): 
    params.add(newParam("ugcid", $ugcid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUGCFileDetails/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetFriendListV1`*(interfacename: ISteamUser, `key`=none(string), `steamid`=none(uint64), `relationship`=none(string)): string = 
  ## `key` : string — (Required) access key
  ## `steamid` : uint64 — (Required) SteamID of user
  ## `relationship` : string — (Optional) relationship type (ex: friend)
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `relationship`.isSome(): 
    params.add(newParam("relationship", $relationship))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetFriendList/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerBansV1`*(interfacename: ISteamUser, `key`=none(string), `steamids`=none(string)): string = 
  ## `key` : string — (Required) access key
  ## `steamids` : string — (Required) Comma-delimited list of SteamIDs
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamids`.isSome(): 
    params.add(newParam("steamids", $steamids))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerBans/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerSummariesV1`*(interfacename: ISteamUser, `key`=none(string), `steamids`=none(string)): string = 
  ## `key` : string — (Required) access key
  ## `steamids` : string — (Required) Comma-delimited list of SteamIDs
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamids`.isSome(): 
    params.add(newParam("steamids", $steamids))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerSummaries/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerSummariesV2`*(interfacename: ISteamUser, `key`=none(string), `steamids`=none(string)): string = 
  ## `key` : string — (Required) access key
  ## `steamids` : string — (Required) Comma-delimited list of SteamIDs (max: 100)
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamids`.isSome(): 
    params.add(newParam("steamids", $steamids))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerSummaries/v2/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetUserGroupListV1`*(interfacename: ISteamUser, `key`=none(string), `steamid`=none(uint64)): string = 
  ## `key` : string — (Required) access key
  ## `steamid` : uint64 — (Required) SteamID of user
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserGroupList/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `ResolveVanityURLV1`*(interfacename: ISteamUser, `key`=none(string), `vanityurl`=none(string), `url_type`=none(int32)): string = 
  ## `key` : string — (Required) access key
  ## `vanityurl` : string — (Required) The vanity URL to get a SteamID for
  ## `url_type` : int32 — (Optional) The type of vanity URL. 1 (default): Individual profile, 2: Group, 3: Official game group
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `vanityurl`.isSome(): 
    params.add(newParam("vanityurl", $vanityurl))
  if `url_type`.isSome(): 
    params.add(newParam("url_type", $url_type))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/ResolveVanityURL/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `AuthenticateUserV1`*(interfacename: ISteamUserAuth, `steamid`=none(uint64), `sessionkey`=none(Rawbinary), `encrypted_loginkey`=none(Rawbinary)): string = 
  ## `steamid` : uint64 — (Required) Should be the users steamid, unencrypted.
  ## `sessionkey` : Rawbinary — (Required) Should be a 32 byte random blob of data, which is then encrypted with RSA using the Steam system's public key.  Randomness is important here for security.
  ## `encrypted_loginkey` : Rawbinary — (Required) Should be the users hashed loginkey, AES encrypted with the sessionkey.
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `sessionkey`.isSome(): 
    params.add(newParam("sessionkey", $sessionkey))
  if `encrypted_loginkey`.isSome(): 
    params.add(newParam("encrypted_loginkey", $encrypted_loginkey))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/AuthenticateUser/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `AuthenticateUserTicketV1`*(interfacename: ISteamUserAuth, `key`=none(string), `appid`=none(uint32), `ticket`=none(string)): string = 
  ## `key` : string — (Required) access key
  ## `appid` : uint32 — (Required) appid of game
  ## `ticket` : string — (Required) Ticket from GetAuthSessionTicket.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `ticket`.isSome(): 
    params.add(newParam("ticket", $ticket))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/AuthenticateUserTicket/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTokenDetailsV1`*(interfacename: ISteamUserOAuth, `access_token`=none(string)): string = 
  ## `access_token` : string — (Required) OAuth2 token for which to return details
  var params: seq[Param]
  if `access_token`.isSome(): 
    params.add(newParam("access_token", $access_token))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTokenDetails/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGlobalAchievementPercentagesForAppV1`*(interfacename: ISteamUserStats, `gameid`=none(uint64)): string = 
  ## `gameid` : uint64 — (Required) GameID to retrieve the achievement percentages for
  var params: seq[Param]
  if `gameid`.isSome(): 
    params.add(newParam("gameid", $gameid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGlobalAchievementPercentagesForApp/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGlobalAchievementPercentagesForAppV2`*(interfacename: ISteamUserStats, `gameid`=none(uint64)): string = 
  ## `gameid` : uint64 — (Required) GameID to retrieve the achievement percentages for
  var params: seq[Param]
  if `gameid`.isSome(): 
    params.add(newParam("gameid", $gameid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGlobalAchievementPercentagesForApp/v2/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGlobalStatsForGameV1`*(interfacename: ISteamUserStats, `appid`=none(uint32), `count`=none(uint32), `name`=none(seq[string]), `startdate`=none(uint32), `enddate`=none(uint32)): string = 
  ## `appid` : uint32 — (Required) AppID that we're getting global stats for
  ## `count` : uint32 — (Required) Number of stats get data for
  ## `name[0]` : string — (Required) Names of stat to get data for
  ## `startdate` : uint32 — (Optional) Start date for daily totals (unix epoch timestamp)
  ## `enddate` : uint32 — (Optional) End date for daily totals (unix epoch timestamp)
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `count`.isSome(): 
    params.add(newParam("count", $count))
  if `name`.isSome(): 
    ## Params for seq[]
  if `startdate`.isSome(): 
    params.add(newParam("startdate", $startdate))
  if `enddate`.isSome(): 
    params.add(newParam("enddate", $enddate))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGlobalStatsForGame/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetNumberOfCurrentPlayersV1`*(interfacename: ISteamUserStats, `appid`=none(uint32)): string = 
  ## `appid` : uint32 — (Required) AppID that we're getting user count for
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNumberOfCurrentPlayers/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerAchievementsV1`*(interfacename: ISteamUserStats, `key`=none(string), `steamid`=none(uint64), `appid`=none(uint32), `l`=none(string)): string = 
  ## `key` : string — (Required) access key
  ## `steamid` : uint64 — (Required) SteamID of user
  ## `appid` : uint32 — (Required) AppID to get achievements for
  ## `l` : string — (Optional) Language to return strings for
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `l`.isSome(): 
    params.add(newParam("l", $l))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerAchievements/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaForGameV1`*(interfacename: ISteamUserStats, `key`=none(string), `appid`=none(uint32), `l`=none(string)): string = 
  ## `key` : string — (Required) access key
  ## `appid` : uint32 — (Required) appid of game
  ## `l` : string — (Optional) localized langauge to return (english, french, etc.)
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `l`.isSome(): 
    params.add(newParam("l", $l))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaForGame/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaForGameV2`*(interfacename: ISteamUserStats, `key`=none(string), `appid`=none(uint32), `l`=none(string)): string = 
  ## `key` : string — (Required) access key
  ## `appid` : uint32 — (Required) appid of game
  ## `l` : string — (Optional) localized language to return (english, french, etc.)
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `l`.isSome(): 
    params.add(newParam("l", $l))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaForGame/v2/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetUserStatsForGameV1`*(interfacename: ISteamUserStats, `key`=none(string), `steamid`=none(uint64), `appid`=none(uint32)): string = 
  ## `key` : string — (Required) access key
  ## `steamid` : uint64 — (Required) SteamID of user
  ## `appid` : uint32 — (Required) appid of game
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserStatsForGame/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetUserStatsForGameV2`*(interfacename: ISteamUserStats, `key`=none(string), `steamid`=none(uint64), `appid`=none(uint32)): string = 
  ## `key` : string — (Required) access key
  ## `steamid` : uint64 — (Required) SteamID of user
  ## `appid` : uint32 — (Required) appid of game
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserStatsForGame/v2/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerInfoV1`*(interfacename: ISteamWebAPIUtil): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerInfo/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSupportedAPIListV1`*(interfacename: ISteamWebAPIUtil, `key`=none(string)): string = 
  ## `key` : string — (Optional) access key
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSupportedAPIList/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `PollStatusV1`*(interfacename: ISteamWebUserPresenceOAuth, `steamid`=none(string), `umqid`=none(uint64), `message`=none(uint32), `pollid`=none(uint32), `sectimeout`=none(uint32), `secidletime`=none(uint32), `use_accountids`=none(uint32)): string = 
  ## `steamid` : string — (Required) Steam ID of the user
  ## `umqid` : uint64 — (Required) UMQ Session ID
  ## `message` : uint32 — (Required) Message that was last known to the user
  ## `pollid` : uint32 — (Optional) Caller-specific poll id
  ## `sectimeout` : uint32 — (Optional) Long-poll timeout in seconds
  ## `secidletime` : uint32 — (Optional) How many seconds is client considering itself idle, e.g. screen is off
  ## `use_accountids` : uint32 — (Optional) Boolean, 0 (default): return steamid_from in output, 1: return accountid_from
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `umqid`.isSome(): 
    params.add(newParam("umqid", $umqid))
  if `message`.isSome(): 
    params.add(newParam("message", $message))
  if `pollid`.isSome(): 
    params.add(newParam("pollid", $pollid))
  if `sectimeout`.isSome(): 
    params.add(newParam("sectimeout", $sectimeout))
  if `secidletime`.isSome(): 
    params.add(newParam("secidletime", $secidletime))
  if `use_accountids`.isSome(): 
    params.add(newParam("use_accountids", $use_accountids))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/PollStatus/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `GetGoldenWrenchesV1`*(interfacename: ITFItems_440): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGoldenWrenches/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGoldenWrenchesV2`*(interfacename: ITFItems_440): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGoldenWrenches/v2/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetItemIDV1`*(interfacename: ITFPromos_205790, `steamid`=none(uint64), `promoid`=none(uint32)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `promoid` : uint32 — (Required) The promo ID to grant an item for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `promoid`.isSome(): 
    params.add(newParam("promoid", $promoid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemID/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GrantItemV1`*(interfacename: ITFPromos_205790, `steamid`=none(uint64), `promoid`=none(uint32)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `promoid` : uint32 — (Required) The promo ID to grant an item for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `promoid`.isSome(): 
    params.add(newParam("promoid", $promoid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GrantItem/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `GetItemIDV1`*(interfacename: ITFPromos_440, `steamid`=none(uint64), `promoid`=none(uint32)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `promoid` : uint32 — (Required) The promo ID to grant an item for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `promoid`.isSome(): 
    params.add(newParam("promoid", $promoid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemID/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GrantItemV1`*(interfacename: ITFPromos_440, `steamid`=none(uint64), `promoid`=none(uint32)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `promoid` : uint32 — (Required) The promo ID to grant an item for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `promoid`.isSome(): 
    params.add(newParam("promoid", $promoid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GrantItem/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `GetItemIDV1`*(interfacename: ITFPromos_620, `steamid`=none(uint64), `PromoID`=none(uint32)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `PromoID` : uint32 — (Required) The promo ID to grant an item for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `PromoID`.isSome(): 
    params.add(newParam("PromoID", $PromoID))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemID/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GrantItemV1`*(interfacename: ITFPromos_620, `steamid`=none(uint64), `PromoID`=none(uint32)): string = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `PromoID` : uint32 — (Required) The promo ID to grant an item for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `PromoID`.isSome(): 
    params.add(newParam("PromoID", $PromoID))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GrantItem/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `GetWorldStatusV1`*(interfacename: ITFSystem_440): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetWorldStatus/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetAccountListV1`*(interfacename: IGameServersService, `key`=none(string)): string = 
  ## Gets a list of game server accounts with their logon tokens
  ## `key` : string — (Required) Access key
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAccountList/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `CreateAccountV1`*(interfacename: IGameServersService, `key`=none(string), `appid`=none(uint32), `memo`=none(string)): string = 
  ## Creates a persistent game server account
  ## `key` : string — (Required) Access key
  ## `appid` : uint32 — (Required) The app to use the account for
  ## `memo` : string — (Required) The memo to set on the new account
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `memo`.isSome(): 
    params.add(newParam("memo", $memo))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/CreateAccount/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `SetMemoV1`*(interfacename: IGameServersService, `key`=none(string), `steamid`=none(uint64), `memo`=none(string)): string = 
  ## This method changes the memo associated with the game server account. Memos do not affect the account in any way. The memo shows up in the GetAccountList response and serves only as a reminder of what the account is used for.
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The SteamID of the game server to set the memo on
  ## `memo` : string — (Required) The memo to set on the new account
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `memo`.isSome(): 
    params.add(newParam("memo", $memo))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetMemo/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `ResetLoginTokenV1`*(interfacename: IGameServersService, `key`=none(string), `steamid`=none(uint64)): string = 
  ## Generates a new login token for the specified game server
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The SteamID of the game server to reset the login token of
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/ResetLoginToken/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `DeleteAccountV1`*(interfacename: IGameServersService, `key`=none(string), `steamid`=none(uint64)): string = 
  ## Deletes a persistent game server account
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The SteamID of the game server account to delete
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/DeleteAccount/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `GetAccountPublicInfoV1`*(interfacename: IGameServersService, `key`=none(string), `steamid`=none(uint64)): string = 
  ## Gets public information about a given game server account
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The SteamID of the game server to get info on
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAccountPublicInfo/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `QueryLoginTokenV1`*(interfacename: IGameServersService, `key`=none(string), `login_token`=none(string)): string = 
  ## Queries the status of the specified token, which must be owned by you
  ## `key` : string — (Required) Access key
  ## `login_token` : string — (Required) Login token to query
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `login_token`.isSome(): 
    params.add(newParam("login_token", $login_token))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/QueryLoginToken/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerSteamIDsByIPV1`*(interfacename: IGameServersService, `key`=none(string), `server_ips`=none(string)): string = 
  ## Gets a list of server SteamIDs given a list of IPs
  ## `key` : string — (Required) Access key
  ## `server_ips` : string — (Required) 
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `server_ips`.isSome(): 
    params.add(newParam("server_ips", $server_ips))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerSteamIDsByIP/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerIPsBySteamIDV1`*(interfacename: IGameServersService, `key`=none(string), `server_steamids`=none(uint64)): string = 
  ## Gets a list of server IP addresses given a list of SteamIDs
  ## `key` : string — (Required) Access key
  ## `server_steamids` : uint64 — (Required) 
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `server_steamids`.isSome(): 
    params.add(newParam("server_steamids", $server_steamids))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerIPsBySteamID/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `QueryByFakeIPV1`*(interfacename: IGameServersService, `key`=none(string), `fake_ip`=none(uint32), `fake_port`=none(uint32), `app_id`=none(uint32), `query_type`=none(int)): string = 
  ## Perform a query on a specific server by FakeIP
  ## `key` : string — (Required) Access key
  ## `fake_ip` : uint32 — (Required) FakeIP of server to query.
  ## `fake_port` : uint32 — (Required) Fake port of server to query.
  ## `app_id` : uint32 — (Required) AppID to use.  Each AppID has its own FakeIP address.
  ## `query_type` : int — (Required) What type of query?
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `fake_ip`.isSome(): 
    params.add(newParam("fake_ip", $fake_ip))
  if `fake_port`.isSome(): 
    params.add(newParam("fake_port", $fake_port))
  if `app_id`.isSome(): 
    params.add(newParam("app_id", $app_id))
  if `query_type`.isSome(): 
    params.add(newParam("query_type", $query_type))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/QueryByFakeIP/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `IsPlayingSharedGameV1`*(interfacename: IPlayerService, `key`=none(string), `steamid`=none(uint64), `appid_playing`=none(uint32)): string = 
  ## Obsolete, partners should use ISteamUser.CheckAppOwnership
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The player we're asking about
  ## `appid_playing` : uint32 — (Required) The game player is currently playing
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `appid_playing`.isSome(): 
    params.add(newParam("appid_playing", $appid_playing))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/IsPlayingSharedGame/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `RecordOfflinePlaytimeV1`*(interfacename: IPlayerService, `steamid`=none(uint64), `ticket`=none(string), `play_sessions`=none(Message)): string = 
  ## Tracks playtime for a user when they are offline
  ## `steamid` : uint64 — (Required) 
  ## `ticket` : string — (Required) 
  ## `play_sessions` : Message — (Required) 
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `ticket`.isSome(): 
    params.add(newParam("ticket", $ticket))
  if `play_sessions`.isSome(): 
    params.add(newParam("play_sessions", $play_sessions))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/RecordOfflinePlaytime/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `GetRecentlyPlayedGamesV1`*(interfacename: IPlayerService, `key`=none(string), `steamid`=none(uint64), `count`=none(uint32)): string = 
  ## Gets information about a player's recently played games
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The player we're asking about
  ## `count` : uint32 — (Required) The number of games to return (0/unset: all)
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `count`.isSome(): 
    params.add(newParam("count", $count))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRecentlyPlayedGames/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetOwnedGamesV1`*(interfacename: IPlayerService, `key`=none(string), `steamid`=none(uint64), `include_appinfo`=none(bool), `include_played_free_games`=none(bool), `appids_filter`=none(uint32), `include_free_sub`=none(bool), `skip_unvetted_apps`=none(bool)): string = 
  ## Return a list of games owned by the player
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The player we're asking about
  ## `include_appinfo` : bool — (Required) true if we want additional details (name, icon) about each game
  ## `include_played_free_games` : bool — (Required) Free games are excluded by default.  If this is set, free games the user has played will be returned.
  ## `appids_filter` : uint32 — (Required) if set, restricts result set to the passed in apps
  ## `include_free_sub` : bool — (Required) Some games are in the free sub, which are excluded by default.
  ## `skip_unvetted_apps` : bool — (Optional) if set, skip unvetted store apps
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `include_appinfo`.isSome(): 
    params.add(newParam("include_appinfo", $include_appinfo))
  if `include_played_free_games`.isSome(): 
    params.add(newParam("include_played_free_games", $include_played_free_games))
  if `appids_filter`.isSome(): 
    params.add(newParam("appids_filter", $appids_filter))
  if `include_free_sub`.isSome(): 
    params.add(newParam("include_free_sub", $include_free_sub))
  if `skip_unvetted_apps`.isSome(): 
    params.add(newParam("skip_unvetted_apps", $skip_unvetted_apps))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetOwnedGames/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSteamLevelV1`*(interfacename: IPlayerService, `key`=none(string), `steamid`=none(uint64)): string = 
  ## Returns the Steam Level of a user
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The player we're asking about
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamLevel/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetBadgesV1`*(interfacename: IPlayerService, `key`=none(string), `steamid`=none(uint64)): string = 
  ## Gets badges that are owned by a specific user
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The player we're asking about
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBadges/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetCommunityBadgeProgressV1`*(interfacename: IPlayerService, `key`=none(string), `steamid`=none(uint64), `badgeid`=none(int32)): string = 
  ## Gets all the quests needed to get the specified badge, and which are completed
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The player we're asking about
  ## `badgeid` : int32 — (Required) The badge we're asking about
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `badgeid`.isSome(): 
    params.add(newParam("badgeid", $badgeid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCommunityBadgeProgress/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `PostGameDataFrameRTMPV1`*(interfacename: IBroadcastService, `appid`=none(uint32), `steamid`=none(uint64), `rtmp_token`=none(string), `frame_data`=none(string)): string = 
  ## Add a game meta data frame to broadcast from a client. Uses RTMP token for validation
  ## `appid` : uint32 — (Required) AppID of the game being broadcasted
  ## `steamid` : uint64 — (Required) Broadcasters SteamID
  ## `rtmp_token` : string — (Required) Valid RTMP token for the Broadcaster
  ## `frame_data` : string — (Required) game data frame expressing current state of game (string, zipped, whatever)
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `rtmp_token`.isSome(): 
    params.add(newParam("rtmp_token", $rtmp_token))
  if `frame_data`.isSome(): 
    params.add(newParam("frame_data", $frame_data))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/PostGameDataFrameRTMP/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `SetSteamCacheClientFiltersV1`*(interfacename: IContentServerConfigService, `key`=none(string), `cache_id`=none(uint32), `cache_key`=none(string), `change_notes`=none(string), `allowed_ip_blocks`=none(string)): string = 
  ## Update the client filters for a SteamCache node
  ## `key` : string — (Required) Access key
  ## `cache_id` : uint32 — (Required) Unique ID number
  ## `cache_key` : string — (Required) Valid current cache API key
  ## `change_notes` : string — (Required) Notes
  ## `allowed_ip_blocks` : string — (Required) comma-separated list of allowed IP address blocks in CIDR format - blank to clear unfilter
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `cache_id`.isSome(): 
    params.add(newParam("cache_id", $cache_id))
  if `cache_key`.isSome(): 
    params.add(newParam("cache_key", $cache_key))
  if `change_notes`.isSome(): 
    params.add(newParam("change_notes", $change_notes))
  if `allowed_ip_blocks`.isSome(): 
    params.add(newParam("allowed_ip_blocks", $allowed_ip_blocks))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamCacheClientFilters/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `GetSteamCacheNodeParamsV1`*(interfacename: IContentServerConfigService, `key`=none(string), `cache_id`=none(uint32), `cache_key`=none(string)): string = 
  ## Get the operational parameters for a SteamCache node (information the node uses to operate).
  ## `key` : string — (Required) Access key
  ## `cache_id` : uint32 — (Required) Unique ID number
  ## `cache_key` : string — (Required) Valid current cache API key
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `cache_id`.isSome(): 
    params.add(newParam("cache_id", $cache_id))
  if `cache_key`.isSome(): 
    params.add(newParam("cache_key", $cache_key))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamCacheNodeParams/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `SetSteamCachePerformanceStatsV1`*(interfacename: IContentServerConfigService, `key`=none(string), `cache_id`=none(uint32), `cache_key`=none(string), `mbps_sent`=none(uint32), `mbps_recv`=none(uint32), `cpu_percent`=none(uint32), `cache_hit_percent`=none(uint32), `num_connected_ips`=none(uint32), `upstream_egress_utilization`=none(uint32)): string = 
  ## Update the performance/load stats for a SteamCache node
  ## `key` : string — (Required) Access key
  ## `cache_id` : uint32 — (Required) Unique ID number
  ## `cache_key` : string — (Required) Valid current cache API key
  ## `mbps_sent` : uint32 — (Required) Outgoing network traffic in Mbps
  ## `mbps_recv` : uint32 — (Required) Incoming network traffic in Mbps
  ## `cpu_percent` : uint32 — (Required) Percent CPU load
  ## `cache_hit_percent` : uint32 — (Required) Percent cache hits
  ## `num_connected_ips` : uint32 — (Required) Number of unique connected IP addresses
  ## `upstream_egress_utilization` : uint32 — (Required) What is the percent utilization of the busiest datacenter egress link?
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `cache_id`.isSome(): 
    params.add(newParam("cache_id", $cache_id))
  if `cache_key`.isSome(): 
    params.add(newParam("cache_key", $cache_key))
  if `mbps_sent`.isSome(): 
    params.add(newParam("mbps_sent", $mbps_sent))
  if `mbps_recv`.isSome(): 
    params.add(newParam("mbps_recv", $mbps_recv))
  if `cpu_percent`.isSome(): 
    params.add(newParam("cpu_percent", $cpu_percent))
  if `cache_hit_percent`.isSome(): 
    params.add(newParam("cache_hit_percent", $cache_hit_percent))
  if `num_connected_ips`.isSome(): 
    params.add(newParam("num_connected_ips", $num_connected_ips))
  if `upstream_egress_utilization`.isSome(): 
    params.add(newParam("upstream_egress_utilization", $upstream_egress_utilization))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamCachePerformanceStats/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `GetServersForSteamPipeV1`*(interfacename: IContentServerDirectoryService, `cell_id`=none(uint32), `max_servers`=none(uint32), `ip_override`=none(string), `launcher_type`=none(int32), `ipv6_public`=none(string)): string = 
  ## `cell_id` : uint32 — (Required) client Cell ID
  ## `max_servers` : uint32 — (Optional) max servers in response list
  ## `ip_override` : string — (Optional) client IP address
  ## `launcher_type` : int32 — (Optional) launcher type
  ## `ipv6_public` : string — (Optional) client public ipv6 address if it knows it
  var params: seq[Param]
  if `cell_id`.isSome(): 
    params.add(newParam("cell_id", $cell_id))
  if `max_servers`.isSome(): 
    params.add(newParam("max_servers", $max_servers))
  if `ip_override`.isSome(): 
    params.add(newParam("ip_override", $ip_override))
  if `launcher_type`.isSome(): 
    params.add(newParam("launcher_type", $launcher_type))
  if `ipv6_public`.isSome(): 
    params.add(newParam("ipv6_public", $ipv6_public))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServersForSteamPipe/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetClientUpdateHostsV1`*(interfacename: IContentServerDirectoryService, `cached_signature`=none(string)): string = 
  ## `cached_signature` : string — (Required) 
  var params: seq[Param]
  if `cached_signature`.isSome(): 
    params.add(newParam("cached_signature", $cached_signature))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientUpdateHosts/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetDepotPatchInfoV1`*(interfacename: IContentServerDirectoryService, `appid`=none(uint32), `depotid`=none(uint32), `source_manifestid`=none(uint64), `target_manifestid`=none(uint64)): string = 
  ## `appid` : uint32 — (Required) 
  ## `depotid` : uint32 — (Required) 
  ## `source_manifestid` : uint64 — (Required) 
  ## `target_manifestid` : uint64 — (Required) 
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `depotid`.isSome(): 
    params.add(newParam("depotid", $depotid))
  if `source_manifestid`.isSome(): 
    params.add(newParam("source_manifestid", $source_manifestid))
  if `target_manifestid`.isSome(): 
    params.add(newParam("target_manifestid", $target_manifestid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetDepotPatchInfo/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetUserVoteSummaryV1`*(interfacename: IPublishedFileService, `publishedfileids`=none(uint64)): string = 
  ## Get user vote summary
  ## `publishedfileids` : uint64 — (Required) 
  var params: seq[Param]
  if `publishedfileids`.isSome(): 
    params.add(newParam("publishedfileids", $publishedfileids))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserVoteSummary/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `QueryFilesV1`*(interfacename: IPublishedFileService, `key`=none(string), `query_type`=none(uint32), `page`=none(uint32), `cursor`=none(string), `numperpage`=none(uint32), `creator_appid`=none(uint32), `appid`=none(uint32), `requiredtags`=none(string), `excludedtags`=none(string), `match_all_tags`=none(bool), `required_flags`=none(string), `omitted_flags`=none(string), `search_text`=none(string), `filetype`=none(uint32), `child_publishedfileid`=none(uint64), `days`=none(uint32), `include_recent_votes_only`=none(bool), `cache_max_age_seconds`=none(uint32), `language`=none(int32), `required_kv_tags`=none(Message), `taggroups`=none(Message), `date_range_created`=none(Message), `date_range_updated`=none(Message), `totalonly`=none(bool), `ids_only`=none(bool), `return_vote_data`=none(bool), `return_tags`=none(bool), `return_kv_tags`=none(bool), `return_previews`=none(bool), `return_children`=none(bool), `return_short_description`=none(bool), `return_for_sale_data`=none(bool), `return_metadata`=none(bool), `return_playtime_stats`=none(uint32), `return_details`=none(bool), `strip_description_bbcode`=none(bool), `desired_revision`=none(int), `return_reactions`=none(bool)): string = 
  ## Performs a search query for published files
  ## `key` : string — (Required) Access key
  ## `query_type` : uint32 — (Required) enumeration EPublishedFileQueryType in clientenums.h
  ## `page` : uint32 — (Required) Current page
  ## `cursor` : string — (Required) Cursor to paginate through the results (set to '*' for the first request).  Prefer this over using the page parameter, as it will allow you to do deep pagination.  When used, the page parameter will be ignored.
  ## `numperpage` : uint32 — (Optional) (Optional) The number of results, per page to return.
  ## `creator_appid` : uint32 — (Required) App that created the files
  ## `appid` : uint32 — (Required) App that consumes the files
  ## `requiredtags` : string — (Required) Tags to match on. See match_all_tags parameter below
  ## `excludedtags` : string — (Required) (Optional) Tags that must NOT be present on a published file to satisfy the query.
  ## `match_all_tags` : bool — (Optional) If true, then items must have all the tags specified, otherwise they must have at least one of the tags.
  ## `required_flags` : string — (Required) Required flags that must be set on any returned items
  ## `omitted_flags` : string — (Required) Flags that must not be set on any returned items
  ## `search_text` : string — (Required) Text to match in the item's title or description
  ## `filetype` : uint32 — (Required) EPublishedFileInfoMatchingFileType
  ## `child_publishedfileid` : uint64 — (Required) Find all items that reference the given item.
  ## `days` : uint32 — (Required) If query_type is k_PublishedFileQueryType_RankedByTrend, then this is the number of days to get votes for [1,7].
  ## `include_recent_votes_only` : bool — (Required) If query_type is k_PublishedFileQueryType_RankedByTrend, then limit result set just to items that have votes within the day range given
  ## `cache_max_age_seconds` : uint32 — (Optional) Allow stale data to be returned for the specified number of seconds.
  ## `language` : int32 — (Optional) Language to search in and also what gets returned. Defaults to English.
  ## `required_kv_tags` : Message — (Required) Required key-value tags to match on.
  ## `taggroups` : Message — (Required) (Optional) At least one of the tags must be present on a published file to satisfy the query.
  ## `date_range_created` : Message — (Required) (Optional) Filter to items created within this range.
  ## `date_range_updated` : Message — (Required) (Optional) Filter to items updated within this range.
  ## `totalonly` : bool — (Required) (Optional) If true, only return the total number of files that satisfy this query.
  ## `ids_only` : bool — (Required) (Optional) If true, only return the published file ids of files that satisfy this query.
  ## `return_vote_data` : bool — (Required) Return vote data
  ## `return_tags` : bool — (Required) Return tags in the file details
  ## `return_kv_tags` : bool — (Required) Return key-value tags in the file details
  ## `return_previews` : bool — (Required) Return preview image and video details in the file details
  ## `return_children` : bool — (Required) Return child item ids in the file details
  ## `return_short_description` : bool — (Required) Populate the short_description field instead of file_description
  ## `return_for_sale_data` : bool — (Required) Return pricing information, if applicable
  ## `return_metadata` : bool — (Optional) Populate the metadata
  ## `return_playtime_stats` : uint32 — (Required) Return playtime stats for the specified number of days before today.
  ## `return_details` : bool — (Required) By default, if none of the other 'return_*' fields are set, only some voting details are returned. Set this to true to return the default set of details.
  ## `strip_description_bbcode` : bool — (Required) Strips BBCode from descriptions.
  ## `desired_revision` : int — (Optional) Return the data for the specified revision.
  ## `return_reactions` : bool — (Optional) If true, then reactions to items will be returned.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `query_type`.isSome(): 
    params.add(newParam("query_type", $query_type))
  if `page`.isSome(): 
    params.add(newParam("page", $page))
  if `cursor`.isSome(): 
    params.add(newParam("cursor", $cursor))
  if `numperpage`.isSome(): 
    params.add(newParam("numperpage", $numperpage))
  if `creator_appid`.isSome(): 
    params.add(newParam("creator_appid", $creator_appid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `requiredtags`.isSome(): 
    params.add(newParam("requiredtags", $requiredtags))
  if `excludedtags`.isSome(): 
    params.add(newParam("excludedtags", $excludedtags))
  if `match_all_tags`.isSome(): 
    params.add(newParam("match_all_tags", $match_all_tags))
  if `required_flags`.isSome(): 
    params.add(newParam("required_flags", $required_flags))
  if `omitted_flags`.isSome(): 
    params.add(newParam("omitted_flags", $omitted_flags))
  if `search_text`.isSome(): 
    params.add(newParam("search_text", $search_text))
  if `filetype`.isSome(): 
    params.add(newParam("filetype", $filetype))
  if `child_publishedfileid`.isSome(): 
    params.add(newParam("child_publishedfileid", $child_publishedfileid))
  if `days`.isSome(): 
    params.add(newParam("days", $days))
  if `include_recent_votes_only`.isSome(): 
    params.add(newParam("include_recent_votes_only", $include_recent_votes_only))
  if `cache_max_age_seconds`.isSome(): 
    params.add(newParam("cache_max_age_seconds", $cache_max_age_seconds))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `required_kv_tags`.isSome(): 
    params.add(newParam("required_kv_tags", $required_kv_tags))
  if `taggroups`.isSome(): 
    params.add(newParam("taggroups", $taggroups))
  if `date_range_created`.isSome(): 
    params.add(newParam("date_range_created", $date_range_created))
  if `date_range_updated`.isSome(): 
    params.add(newParam("date_range_updated", $date_range_updated))
  if `totalonly`.isSome(): 
    params.add(newParam("totalonly", $totalonly))
  if `ids_only`.isSome(): 
    params.add(newParam("ids_only", $ids_only))
  if `return_vote_data`.isSome(): 
    params.add(newParam("return_vote_data", $return_vote_data))
  if `return_tags`.isSome(): 
    params.add(newParam("return_tags", $return_tags))
  if `return_kv_tags`.isSome(): 
    params.add(newParam("return_kv_tags", $return_kv_tags))
  if `return_previews`.isSome(): 
    params.add(newParam("return_previews", $return_previews))
  if `return_children`.isSome(): 
    params.add(newParam("return_children", $return_children))
  if `return_short_description`.isSome(): 
    params.add(newParam("return_short_description", $return_short_description))
  if `return_for_sale_data`.isSome(): 
    params.add(newParam("return_for_sale_data", $return_for_sale_data))
  if `return_metadata`.isSome(): 
    params.add(newParam("return_metadata", $return_metadata))
  if `return_playtime_stats`.isSome(): 
    params.add(newParam("return_playtime_stats", $return_playtime_stats))
  if `return_details`.isSome(): 
    params.add(newParam("return_details", $return_details))
  if `strip_description_bbcode`.isSome(): 
    params.add(newParam("strip_description_bbcode", $strip_description_bbcode))
  if `desired_revision`.isSome(): 
    params.add(newParam("desired_revision", $desired_revision))
  if `return_reactions`.isSome(): 
    params.add(newParam("return_reactions", $return_reactions))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/QueryFiles/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetDetailsV1`*(interfacename: IPublishedFileService, `key`=none(string), `publishedfileids`=none(uint64), `includetags`=none(bool), `includeadditionalpreviews`=none(bool), `includechildren`=none(bool), `includekvtags`=none(bool), `includevotes`=none(bool), `short_description`=none(bool), `includeforsaledata`=none(bool), `includemetadata`=none(bool), `language`=none(int32), `return_playtime_stats`=none(uint32), `appid`=none(uint32), `strip_description_bbcode`=none(bool), `desired_revision`=none(int), `includereactions`=none(bool)): string = 
  ## Retrieves information about a set of published files.
  ## `key` : string — (Required) Access key
  ## `publishedfileids` : uint64 — (Required) Set of published file Ids to retrieve details for.
  ## `includetags` : bool — (Required) If true, return tag information in the returned details.
  ## `includeadditionalpreviews` : bool — (Required) If true, return preview information in the returned details.
  ## `includechildren` : bool — (Required) If true, return children in the returned details.
  ## `includekvtags` : bool — (Required) If true, return key value tags in the returned details.
  ## `includevotes` : bool — (Required) If true, return vote data in the returned details.
  ## `short_description` : bool — (Required) If true, return a short description instead of the full description.
  ## `includeforsaledata` : bool — (Required) If true, return pricing data, if applicable.
  ## `includemetadata` : bool — (Required) If true, populate the metadata field.
  ## `language` : int32 — (Optional) Specifies the localized text to return. Defaults to English.
  ## `return_playtime_stats` : uint32 — (Required) Return playtime stats for the specified number of days before today.
  ## `appid` : uint32 — (Required) 
  ## `strip_description_bbcode` : bool — (Required) Strips BBCode from descriptions.
  ## `desired_revision` : int — (Optional) Return the data for the specified revision.
  ## `includereactions` : bool — (Optional) If true, then reactions to items will be returned.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `publishedfileids`.isSome(): 
    params.add(newParam("publishedfileids", $publishedfileids))
  if `includetags`.isSome(): 
    params.add(newParam("includetags", $includetags))
  if `includeadditionalpreviews`.isSome(): 
    params.add(newParam("includeadditionalpreviews", $includeadditionalpreviews))
  if `includechildren`.isSome(): 
    params.add(newParam("includechildren", $includechildren))
  if `includekvtags`.isSome(): 
    params.add(newParam("includekvtags", $includekvtags))
  if `includevotes`.isSome(): 
    params.add(newParam("includevotes", $includevotes))
  if `short_description`.isSome(): 
    params.add(newParam("short_description", $short_description))
  if `includeforsaledata`.isSome(): 
    params.add(newParam("includeforsaledata", $includeforsaledata))
  if `includemetadata`.isSome(): 
    params.add(newParam("includemetadata", $includemetadata))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `return_playtime_stats`.isSome(): 
    params.add(newParam("return_playtime_stats", $return_playtime_stats))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `strip_description_bbcode`.isSome(): 
    params.add(newParam("strip_description_bbcode", $strip_description_bbcode))
  if `desired_revision`.isSome(): 
    params.add(newParam("desired_revision", $desired_revision))
  if `includereactions`.isSome(): 
    params.add(newParam("includereactions", $includereactions))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetDetails/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetUserFilesV1`*(interfacename: IPublishedFileService, `key`=none(string), `steamid`=none(uint64), `appid`=none(uint32), `page`=none(uint32), `numperpage`=none(uint32), `type`=none(string), `sortmethod`=none(string), `privacy`=none(uint32), `requiredtags`=none(string), `excludedtags`=none(string), `required_kv_tags`=none(Message), `filetype`=none(uint32), `creator_appid`=none(uint32), `match_cloud_filename`=none(string), `cache_max_age_seconds`=none(uint32), `language`=none(int32), `taggroups`=none(Message), `totalonly`=none(bool), `ids_only`=none(bool), `return_vote_data`=none(bool), `return_tags`=none(bool), `return_kv_tags`=none(bool), `return_previews`=none(bool), `return_children`=none(bool), `return_short_description`=none(bool), `return_for_sale_data`=none(bool), `return_metadata`=none(bool), `return_playtime_stats`=none(uint32), `strip_description_bbcode`=none(bool), `return_reactions`=none(bool), `startindex_override`=none(uint32), `desired_revision`=none(int)): string = 
  ## Retrieves files published by a user.
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) Steam ID of the user whose files are being requested.
  ## `appid` : uint32 — (Required) App Id of the app that the files were published to.
  ## `page` : uint32 — (Optional) (Optional) Starting page for results.
  ## `numperpage` : uint32 — (Optional) (Optional) The number of results, per page to return.
  ## `type` : string — (Optional) (Optional) Type of files to be returned.
  ## `sortmethod` : string — (Optional) (Optional) Sorting method to use on returned values.
  ## `privacy` : uint32 — (Required) (optional) Filter by privacy settings.
  ## `requiredtags` : string — (Required) (Optional) Tags that must be present on a published file to satisfy the query.
  ## `excludedtags` : string — (Required) (Optional) Tags that must NOT be present on a published file to satisfy the query.
  ## `required_kv_tags` : Message — (Required) Required key-value tags to match on.
  ## `filetype` : uint32 — (Required) (Optional) File type to match files to.
  ## `creator_appid` : uint32 — (Required) App Id of the app that published the files, only matched if specified.
  ## `match_cloud_filename` : string — (Required) Match this cloud filename if specified.
  ## `cache_max_age_seconds` : uint32 — (Optional) Allow stale data to be returned for the specified number of seconds.
  ## `language` : int32 — (Optional) Specifies the localized text to return. Defaults to English.
  ## `taggroups` : Message — (Required) (Optional) At least one of the tags must be present on a published file to satisfy the query.
  ## `totalonly` : bool — (Required) (Optional) If true, only return the total number of files that satisfy this query.
  ## `ids_only` : bool — (Required) (Optional) If true, only return the published file ids of files that satisfy this query.
  ## `return_vote_data` : bool — (Optional) Return vote data
  ## `return_tags` : bool — (Required) Return tags in the file details
  ## `return_kv_tags` : bool — (Optional) Return key-value tags in the file details
  ## `return_previews` : bool — (Required) Return preview image and video details in the file details
  ## `return_children` : bool — (Required) Return child item ids in the file details
  ## `return_short_description` : bool — (Optional) Populate the short_description field instead of file_description
  ## `return_for_sale_data` : bool — (Required) Return pricing information, if applicable
  ## `return_metadata` : bool — (Optional) Populate the metadata field
  ## `return_playtime_stats` : uint32 — (Required) Return playtime stats for the specified number of days before today.
  ## `strip_description_bbcode` : bool — (Required) Strips BBCode from descriptions.
  ## `return_reactions` : bool — (Optional) If true, then reactions to items will be returned.
  ## `startindex_override` : uint32 — (Required) Backwards compatible for the client.
  ## `desired_revision` : int — (Optional) Return the data for the specified revision.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `page`.isSome(): 
    params.add(newParam("page", $page))
  if `numperpage`.isSome(): 
    params.add(newParam("numperpage", $numperpage))
  if `type`.isSome(): 
    params.add(newParam("type", $type))
  if `sortmethod`.isSome(): 
    params.add(newParam("sortmethod", $sortmethod))
  if `privacy`.isSome(): 
    params.add(newParam("privacy", $privacy))
  if `requiredtags`.isSome(): 
    params.add(newParam("requiredtags", $requiredtags))
  if `excludedtags`.isSome(): 
    params.add(newParam("excludedtags", $excludedtags))
  if `required_kv_tags`.isSome(): 
    params.add(newParam("required_kv_tags", $required_kv_tags))
  if `filetype`.isSome(): 
    params.add(newParam("filetype", $filetype))
  if `creator_appid`.isSome(): 
    params.add(newParam("creator_appid", $creator_appid))
  if `match_cloud_filename`.isSome(): 
    params.add(newParam("match_cloud_filename", $match_cloud_filename))
  if `cache_max_age_seconds`.isSome(): 
    params.add(newParam("cache_max_age_seconds", $cache_max_age_seconds))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `taggroups`.isSome(): 
    params.add(newParam("taggroups", $taggroups))
  if `totalonly`.isSome(): 
    params.add(newParam("totalonly", $totalonly))
  if `ids_only`.isSome(): 
    params.add(newParam("ids_only", $ids_only))
  if `return_vote_data`.isSome(): 
    params.add(newParam("return_vote_data", $return_vote_data))
  if `return_tags`.isSome(): 
    params.add(newParam("return_tags", $return_tags))
  if `return_kv_tags`.isSome(): 
    params.add(newParam("return_kv_tags", $return_kv_tags))
  if `return_previews`.isSome(): 
    params.add(newParam("return_previews", $return_previews))
  if `return_children`.isSome(): 
    params.add(newParam("return_children", $return_children))
  if `return_short_description`.isSome(): 
    params.add(newParam("return_short_description", $return_short_description))
  if `return_for_sale_data`.isSome(): 
    params.add(newParam("return_for_sale_data", $return_for_sale_data))
  if `return_metadata`.isSome(): 
    params.add(newParam("return_metadata", $return_metadata))
  if `return_playtime_stats`.isSome(): 
    params.add(newParam("return_playtime_stats", $return_playtime_stats))
  if `strip_description_bbcode`.isSome(): 
    params.add(newParam("strip_description_bbcode", $strip_description_bbcode))
  if `return_reactions`.isSome(): 
    params.add(newParam("return_reactions", $return_reactions))
  if `startindex_override`.isSome(): 
    params.add(newParam("startindex_override", $startindex_override))
  if `desired_revision`.isSome(): 
    params.add(newParam("desired_revision", $desired_revision))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserFiles/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTradeHistoryV1`*(interfacename: IEconService, `key`=none(string), `max_trades`=none(uint32), `start_after_time`=none(uint32), `start_after_tradeid`=none(uint64), `navigating_back`=none(bool), `get_descriptions`=none(bool), `language`=none(string), `include_failed`=none(bool), `include_total`=none(bool)): string = 
  ## Gets a history of trades
  ## `key` : string — (Required) Access key
  ## `max_trades` : uint32 — (Required) The number of trades to return information for
  ## `start_after_time` : uint32 — (Required) The time of the last trade shown on the previous page of results, or the time of the first trade if navigating back
  ## `start_after_tradeid` : uint64 — (Required) The tradeid shown on the previous page of results, or the ID of the first trade if navigating back
  ## `navigating_back` : bool — (Required) The user wants the previous page of results, so return the previous max_trades trades before the start time and ID
  ## `get_descriptions` : bool — (Required) If set, the item display data for the items included in the returned trades will also be returned
  ## `language` : string — (Required) The language to use when loading item display data
  ## `include_failed` : bool — (Required) 
  ## `include_total` : bool — (Required) If set, the total number of trades the account has participated in will be included in the response
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `max_trades`.isSome(): 
    params.add(newParam("max_trades", $max_trades))
  if `start_after_time`.isSome(): 
    params.add(newParam("start_after_time", $start_after_time))
  if `start_after_tradeid`.isSome(): 
    params.add(newParam("start_after_tradeid", $start_after_tradeid))
  if `navigating_back`.isSome(): 
    params.add(newParam("navigating_back", $navigating_back))
  if `get_descriptions`.isSome(): 
    params.add(newParam("get_descriptions", $get_descriptions))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `include_failed`.isSome(): 
    params.add(newParam("include_failed", $include_failed))
  if `include_total`.isSome(): 
    params.add(newParam("include_total", $include_total))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeHistory/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTradeStatusV1`*(interfacename: IEconService, `key`=none(string), `tradeid`=none(uint64), `get_descriptions`=none(bool), `language`=none(string)): string = 
  ## Gets status for a specific trade
  ## `key` : string — (Required) Access key
  ## `tradeid` : uint64 — (Required) 
  ## `get_descriptions` : bool — (Required) If set, the item display data for the items included in the returned trades will also be returned
  ## `language` : string — (Required) The language to use when loading item display data
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `tradeid`.isSome(): 
    params.add(newParam("tradeid", $tradeid))
  if `get_descriptions`.isSome(): 
    params.add(newParam("get_descriptions", $get_descriptions))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeStatus/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTradeOffersV1`*(interfacename: IEconService, `key`=none(string), `get_sent_offers`=none(bool), `get_received_offers`=none(bool), `get_descriptions`=none(bool), `language`=none(string), `active_only`=none(bool), `historical_only`=none(bool), `time_historical_cutoff`=none(uint32), `cursor`=none(uint32)): string = 
  ## Get a list of sent or received trade offers
  ## `key` : string — (Required) Access key
  ## `get_sent_offers` : bool — (Required) Request the list of sent offers.
  ## `get_received_offers` : bool — (Required) Request the list of received offers.
  ## `get_descriptions` : bool — (Required) If set, the item display data for the items included in the returned trade offers will also be returned. If one or more descriptions can't be retrieved, then your request will fail.
  ## `language` : string — (Required) The language to use when loading item display data.
  ## `active_only` : bool — (Required) Indicates we should only return offers which are still active, or offers that have changed in state since the time_historical_cutoff
  ## `historical_only` : bool — (Required) Indicates we should only return offers which are not active.
  ## `time_historical_cutoff` : uint32 — (Required) When active_only is set, offers updated since this time will also be returned
  ## `cursor` : uint32 — (Optional) Cursor aka start index
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `get_sent_offers`.isSome(): 
    params.add(newParam("get_sent_offers", $get_sent_offers))
  if `get_received_offers`.isSome(): 
    params.add(newParam("get_received_offers", $get_received_offers))
  if `get_descriptions`.isSome(): 
    params.add(newParam("get_descriptions", $get_descriptions))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `active_only`.isSome(): 
    params.add(newParam("active_only", $active_only))
  if `historical_only`.isSome(): 
    params.add(newParam("historical_only", $historical_only))
  if `time_historical_cutoff`.isSome(): 
    params.add(newParam("time_historical_cutoff", $time_historical_cutoff))
  if `cursor`.isSome(): 
    params.add(newParam("cursor", $cursor))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeOffers/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTradeOfferV1`*(interfacename: IEconService, `key`=none(string), `tradeofferid`=none(uint64), `language`=none(string), `get_descriptions`=none(bool)): string = 
  ## Gets a specific trade offer
  ## `key` : string — (Required) Access key
  ## `tradeofferid` : uint64 — (Required) 
  ## `language` : string — (Required) 
  ## `get_descriptions` : bool — (Required) If set, the item display data for the items included in the returned trade offers will also be returned. If one or more descriptions can't be retrieved, then your request will fail.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `tradeofferid`.isSome(): 
    params.add(newParam("tradeofferid", $tradeofferid))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `get_descriptions`.isSome(): 
    params.add(newParam("get_descriptions", $get_descriptions))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeOffer/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTradeOffersSummaryV1`*(interfacename: IEconService, `key`=none(string), `time_last_visit`=none(uint32)): string = 
  ## Get counts of pending and new trade offers
  ## `key` : string — (Required) Access key
  ## `time_last_visit` : uint32 — (Required) The time the user last visited.  If not passed, will use the time the user last visited the trade offer page.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `time_last_visit`.isSome(): 
    params.add(newParam("time_last_visit", $time_last_visit))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeOffersSummary/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTradeHoldDurationsV1`*(interfacename: IEconService, `key`=none(string), `steamid_target`=none(uint64), `trade_offer_access_token`=none(string)): string = 
  ## Returns the estimated hold duration and end date that a trade with a user would have
  ## `key` : string — (Required) Access key
  ## `steamid_target` : uint64 — (Required) User you are trading with
  ## `trade_offer_access_token` : string — (Required) A special token that allows for trade offers from non-friends.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid_target`.isSome(): 
    params.add(newParam("steamid_target", $steamid_target))
  if `trade_offer_access_token`.isSome(): 
    params.add(newParam("trade_offer_access_token", $trade_offer_access_token))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeHoldDurations/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `UserCreateSessionV1`*(interfacename: IGameNotificationsService, `appid`=none(uint32), `context`=none(uint64), `title`=none(Message), `users`=none(Message), `steamid`=none(uint64)): string = 
  ## Creates an async game session
  ## `appid` : uint32 — (Required) The appid to create the session for.
  ## `context` : uint64 — (Required) Game-specified context value the game can used to associate the session with some object on their backend.
  ## `title` : Message — (Required) The title of the session to be displayed within each user's list of sessions.
  ## `users` : Message — (Required) The initial state of all users in the session.
  ## `steamid` : uint64 — (Required) (Optional) steamid to make the request on behalf of -- if specified, the user must be in the session and all users being added to the session must be friends with the user.
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `context`.isSome(): 
    params.add(newParam("context", $context))
  if `title`.isSome(): 
    params.add(newParam("title", $title))
  if `users`.isSome(): 
    params.add(newParam("users", $users))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UserCreateSession/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `UserUpdateSessionV1`*(interfacename: IGameNotificationsService, `sessionid`=none(uint64), `appid`=none(uint32), `title`=none(Message), `users`=none(Message), `steamid`=none(uint64)): string = 
  ## Updates an async game session
  ## `sessionid` : uint64 — (Required) The sessionid to update.
  ## `appid` : uint32 — (Required) The appid of the session to update.
  ## `title` : Message — (Required) (Optional) The new title of the session.  If not specified, the title will not be changed.
  ## `users` : Message — (Required) (Optional) A list of users whose state will be updated to reflect the given state. If the users are not already in the session, they will be added to it.
  ## `steamid` : uint64 — (Required) (Optional) steamid to make the request on behalf of -- if specified, the user must be in the session and all users being added to the session must be friends with the user.
  var params: seq[Param]
  if `sessionid`.isSome(): 
    params.add(newParam("sessionid", $sessionid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `title`.isSome(): 
    params.add(newParam("title", $title))
  if `users`.isSome(): 
    params.add(newParam("users", $users))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UserUpdateSession/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `UserDeleteSessionV1`*(interfacename: IGameNotificationsService, `sessionid`=none(uint64), `appid`=none(uint32), `steamid`=none(uint64)): string = 
  ## Deletes an async game session
  ## `sessionid` : uint64 — (Required) The sessionid to delete.
  ## `appid` : uint32 — (Required) The appid of the session to delete.
  ## `steamid` : uint64 — (Required) (Optional) steamid to make the request on behalf of -- if specified, the user must be in the session.
  var params: seq[Param]
  if `sessionid`.isSome(): 
    params.add(newParam("sessionid", $sessionid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UserDeleteSession/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `SplitItemStackV1`*(interfacename: IInventoryService, `key`=none(string), `appid`=none(uint32), `itemid`=none(uint64), `quantity`=none(uint32), `steamid`=none(uint64)): string = 
  ## Split an item stack into two stacks
  ## `key` : string — (Required) Access key
  ## `appid` : uint32 — (Required) 
  ## `itemid` : uint64 — (Required) 
  ## `quantity` : uint32 — (Required) 
  ## `steamid` : uint64 — (Required) 
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `itemid`.isSome(): 
    params.add(newParam("itemid", $itemid))
  if `quantity`.isSome(): 
    params.add(newParam("quantity", $quantity))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SplitItemStack/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `CombineItemStacksV1`*(interfacename: IInventoryService, `key`=none(string), `appid`=none(uint32), `fromitemid`=none(uint64), `destitemid`=none(uint64), `quantity`=none(uint32), `steamid`=none(uint64)): string = 
  ## Combine two stacks of items
  ## `key` : string — (Required) Access key
  ## `appid` : uint32 — (Required) 
  ## `fromitemid` : uint64 — (Required) 
  ## `destitemid` : uint64 — (Required) 
  ## `quantity` : uint32 — (Required) 
  ## `steamid` : uint64 — (Required) 
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `fromitemid`.isSome(): 
    params.add(newParam("fromitemid", $fromitemid))
  if `destitemid`.isSome(): 
    params.add(newParam("destitemid", $destitemid))
  if `quantity`.isSome(): 
    params.add(newParam("quantity", $quantity))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/CombineItemStacks/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `GetPriceSheetV1`*(interfacename: IInventoryService, `key`=none(string), `ecurrency`=none(int32), `currency_code`=none(string)): string = 
  ## Get the Inventory Service price sheet
  ## `key` : string — (Required) Access key
  ## `ecurrency` : int32 — (Required) 
  ## `currency_code` : string — (Required) Standard short code of the requested currency (preferred)
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `ecurrency`.isSome(): 
    params.add(newParam("ecurrency", $ecurrency))
  if `currency_code`.isSome(): 
    params.add(newParam("currency_code", $currency_code))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPriceSheet/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetAppListV1`*(interfacename: IStoreService, `key`=none(string), `if_modified_since`=none(uint32), `have_description_language`=none(string), `include_games`=none(bool), `include_dlc`=none(bool), `include_software`=none(bool), `include_videos`=none(bool), `include_hardware`=none(bool), `last_appid`=none(uint32), `max_results`=none(uint32)): string = 
  ## Gets a list of apps available on the Steam Store.
  ## `key` : string — (Required) Access key
  ## `if_modified_since` : uint32 — (Optional) Return only items that have been modified since this date.
  ## `have_description_language` : string — (Optional) Return only items that have a description in this language.
  ## `include_games` : bool — (Optional) Include games (defaults to enabled)
  ## `include_dlc` : bool — (Optional) Include DLC
  ## `include_software` : bool — (Optional) Include software items
  ## `include_videos` : bool — (Optional) Include videos and series
  ## `include_hardware` : bool — (Optional) Include hardware
  ## `last_appid` : uint32 — (Optional) For continuations, this is the last appid returned from the previous call.
  ## `max_results` : uint32 — (Optional) Number of results to return at a time.  Default 10k, max 50k.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `if_modified_since`.isSome(): 
    params.add(newParam("if_modified_since", $if_modified_since))
  if `have_description_language`.isSome(): 
    params.add(newParam("have_description_language", $have_description_language))
  if `include_games`.isSome(): 
    params.add(newParam("include_games", $include_games))
  if `include_dlc`.isSome(): 
    params.add(newParam("include_dlc", $include_dlc))
  if `include_software`.isSome(): 
    params.add(newParam("include_software", $include_software))
  if `include_videos`.isSome(): 
    params.add(newParam("include_videos", $include_videos))
  if `include_hardware`.isSome(): 
    params.add(newParam("include_hardware", $include_hardware))
  if `last_appid`.isSome(): 
    params.add(newParam("last_appid", $last_appid))
  if `max_results`.isSome(): 
    params.add(newParam("max_results", $max_results))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAppList/v1/"&prm2get(params)
  var client = newHttpClient()
  return client.getContent(url) 

proc `ReportCheatDataV1`*(interfacename: ICheatReportingService, `key`=none(string), `steamid`=none(uint64), `appid`=none(uint32), `pathandfilename`=none(string), `webcheaturl`=none(string), `time_now`=none(uint64), `time_started`=none(uint64), `time_stopped`=none(uint64), `cheatname`=none(string), `game_process_id`=none(uint32), `cheat_process_id`=none(uint32), `cheat_param_1`=none(uint64), `cheat_param_2`=none(uint64), `cheat_data_dump`=none(string)): string = 
  ## Reports cheat data. Only use on test account that is running the game but not in a multiplayer session.
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) steamid of the user running and reporting the cheat.
  ## `appid` : uint32 — (Required) The appid.
  ## `pathandfilename` : string — (Required) path and file name of the cheat executable.
  ## `webcheaturl` : string — (Required) web url where the cheat was found and downloaded.
  ## `time_now` : uint64 — (Required) local system time now.
  ## `time_started` : uint64 — (Required) local system time when cheat process started. ( 0 if not yet run )
  ## `time_stopped` : uint64 — (Required) local system time when cheat process stopped. ( 0 if still running )
  ## `cheatname` : string — (Required) descriptive name for the cheat.
  ## `game_process_id` : uint32 — (Required) process ID of the running game.
  ## `cheat_process_id` : uint32 — (Required) process ID of the cheat process that ran
  ## `cheat_param_1` : uint64 — (Required) cheat param 1
  ## `cheat_param_2` : uint64 — (Required) cheat param 2
  ## `cheat_data_dump` : string — (Required) data collection in json format
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `pathandfilename`.isSome(): 
    params.add(newParam("pathandfilename", $pathandfilename))
  if `webcheaturl`.isSome(): 
    params.add(newParam("webcheaturl", $webcheaturl))
  if `time_now`.isSome(): 
    params.add(newParam("time_now", $time_now))
  if `time_started`.isSome(): 
    params.add(newParam("time_started", $time_started))
  if `time_stopped`.isSome(): 
    params.add(newParam("time_stopped", $time_stopped))
  if `cheatname`.isSome(): 
    params.add(newParam("cheatname", $cheatname))
  if `game_process_id`.isSome(): 
    params.add(newParam("game_process_id", $game_process_id))
  if `cheat_process_id`.isSome(): 
    params.add(newParam("cheat_process_id", $cheat_process_id))
  if `cheat_param_1`.isSome(): 
    params.add(newParam("cheat_param_1", $cheat_param_1))
  if `cheat_param_2`.isSome(): 
    params.add(newParam("cheat_param_2", $cheat_param_2))
  if `cheat_data_dump`.isSome(): 
    params.add(newParam("cheat_data_dump", $cheat_data_dump))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/ReportCheatData/v1/"
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return client.postContent(url, body = body) 

proc `ReportEventV1`*(interfacename: AsyncIClientStats_1046930): Future[string] {.async.} = 
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/ReportEvent/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url) 

proc `GetNextMatchSharingCodeV1`*(interfacename: AsyncICSGOPlayers_730, `steamid`=none(uint64), `steamidkey`=none(string), `knowncode`=none(string)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The SteamID of the user
  ## `steamidkey` : string — (Required) Authentication obtained from the SteamID
  ## `knowncode` : string — (Required) Previously known match sharing code obtained from the SteamID
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `steamidkey`.isSome(): 
    params.add(newParam("steamidkey", $steamidkey))
  if `knowncode`.isSome(): 
    params.add(newParam("knowncode", $knowncode))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNextMatchSharingCode/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGameMapsPlaytimeV1`*(interfacename: AsyncICSGOServers_730, `interval`=none(string), `gamemode`=none(string), `mapgroup`=none(string)): Future[string] {.async.} = 
  ## `interval` : string — (Required) What recent interval is requested, possible values: day, week, month
  ## `gamemode` : string — (Required) What game mode is requested, possible values: competitive, casual
  ## `mapgroup` : string — (Required) What maps are requested, possible values: operation
  var params: seq[Param]
  if `interval`.isSome(): 
    params.add(newParam("interval", $interval))
  if `gamemode`.isSome(): 
    params.add(newParam("gamemode", $gamemode))
  if `mapgroup`.isSome(): 
    params.add(newParam("mapgroup", $mapgroup))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameMapsPlaytime/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGameServersStatusV1`*(interfacename: AsyncICSGOServers_730): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameServersStatus/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentFantasyLineupV1`*(interfacename: AsyncICSGOTournaments_730, `event`=none(uint32), `steamid`=none(uint64), `steamidkey`=none(string)): Future[string] {.async.} = 
  ## `event` : uint32 — (Required) The event ID
  ## `steamid` : uint64 — (Required) The SteamID of the user inventory
  ## `steamidkey` : string — (Required) Authentication obtained from the SteamID
  var params: seq[Param]
  if `event`.isSome(): 
    params.add(newParam("event", $event))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `steamidkey`.isSome(): 
    params.add(newParam("steamidkey", $steamidkey))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentFantasyLineup/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentItemsV1`*(interfacename: AsyncICSGOTournaments_730, `event`=none(uint32), `steamid`=none(uint64), `steamidkey`=none(string)): Future[string] {.async.} = 
  ## `event` : uint32 — (Required) The event ID
  ## `steamid` : uint64 — (Required) The SteamID of the user inventory
  ## `steamidkey` : string — (Required) Authentication obtained from the SteamID
  var params: seq[Param]
  if `event`.isSome(): 
    params.add(newParam("event", $event))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `steamidkey`.isSome(): 
    params.add(newParam("steamidkey", $steamidkey))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentLayoutV1`*(interfacename: AsyncICSGOTournaments_730, `event`=none(uint32)): Future[string] {.async.} = 
  ## `event` : uint32 — (Required) The event ID
  var params: seq[Param]
  if `event`.isSome(): 
    params.add(newParam("event", $event))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentLayout/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentPredictionsV1`*(interfacename: AsyncICSGOTournaments_730, `event`=none(uint32), `steamid`=none(uint64), `steamidkey`=none(string)): Future[string] {.async.} = 
  ## `event` : uint32 — (Required) The event ID
  ## `steamid` : uint64 — (Required) The SteamID of the user inventory
  ## `steamidkey` : string — (Required) Authentication obtained from the SteamID
  var params: seq[Param]
  if `event`.isSome(): 
    params.add(newParam("event", $event))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `steamidkey`.isSome(): 
    params.add(newParam("steamidkey", $steamidkey))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPredictions/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `UploadTournamentFantasyLineupV1`*(interfacename: AsyncICSGOTournaments_730, `event`=none(uint32), `steamid`=none(uint64), `steamidkey`=none(string), `sectionid`=none(uint32), `pickid0`=none(uint32), `itemid0`=none(uint64), `pickid1`=none(uint32), `itemid1`=none(uint64), `pickid2`=none(uint32), `itemid2`=none(uint64), `pickid3`=none(uint32), `itemid3`=none(uint64), `pickid4`=none(uint32), `itemid4`=none(uint64)): Future[string] {.async.} = 
  ## `event` : uint32 — (Required) The event ID
  ## `steamid` : uint64 — (Required) The SteamID of the user inventory
  ## `steamidkey` : string — (Required) Authentication obtained from the SteamID
  ## `sectionid` : uint32 — (Required) Event section id
  ## `pickid0` : uint32 — (Required) PickID to select for the slot
  ## `itemid0` : uint64 — (Required) ItemID to lock in for the pick
  ## `pickid1` : uint32 — (Required) PickID to select for the slot
  ## `itemid1` : uint64 — (Required) ItemID to lock in for the pick
  ## `pickid2` : uint32 — (Required) PickID to select for the slot
  ## `itemid2` : uint64 — (Required) ItemID to lock in for the pick
  ## `pickid3` : uint32 — (Required) PickID to select for the slot
  ## `itemid3` : uint64 — (Required) ItemID to lock in for the pick
  ## `pickid4` : uint32 — (Required) PickID to select for the slot
  ## `itemid4` : uint64 — (Required) ItemID to lock in for the pick
  var params: seq[Param]
  if `event`.isSome(): 
    params.add(newParam("event", $event))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `steamidkey`.isSome(): 
    params.add(newParam("steamidkey", $steamidkey))
  if `sectionid`.isSome(): 
    params.add(newParam("sectionid", $sectionid))
  if `pickid0`.isSome(): 
    params.add(newParam("pickid0", $pickid0))
  if `itemid0`.isSome(): 
    params.add(newParam("itemid0", $itemid0))
  if `pickid1`.isSome(): 
    params.add(newParam("pickid1", $pickid1))
  if `itemid1`.isSome(): 
    params.add(newParam("itemid1", $itemid1))
  if `pickid2`.isSome(): 
    params.add(newParam("pickid2", $pickid2))
  if `itemid2`.isSome(): 
    params.add(newParam("itemid2", $itemid2))
  if `pickid3`.isSome(): 
    params.add(newParam("pickid3", $pickid3))
  if `itemid3`.isSome(): 
    params.add(newParam("itemid3", $itemid3))
  if `pickid4`.isSome(): 
    params.add(newParam("pickid4", $pickid4))
  if `itemid4`.isSome(): 
    params.add(newParam("itemid4", $itemid4))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UploadTournamentFantasyLineup/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `UploadTournamentPredictionsV1`*(interfacename: AsyncICSGOTournaments_730, `event`=none(uint32), `steamid`=none(uint64), `steamidkey`=none(string), `sectionid`=none(uint32), `groupid`=none(uint32), `index`=none(uint32), `pickid`=none(uint32), `itemid`=none(uint64)): Future[string] {.async.} = 
  ## `event` : uint32 — (Required) The event ID
  ## `steamid` : uint64 — (Required) The SteamID of the user inventory
  ## `steamidkey` : string — (Required) Authentication obtained from the SteamID
  ## `sectionid` : uint32 — (Required) Event section id
  ## `groupid` : uint32 — (Required) Event group id
  ## `index` : uint32 — (Required) Index in group
  ## `pickid` : uint32 — (Required) Pick ID to select
  ## `itemid` : uint64 — (Required) ItemID to lock in for the pick
  var params: seq[Param]
  if `event`.isSome(): 
    params.add(newParam("event", $event))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `steamidkey`.isSome(): 
    params.add(newParam("steamidkey", $steamidkey))
  if `sectionid`.isSome(): 
    params.add(newParam("sectionid", $sectionid))
  if `groupid`.isSome(): 
    params.add(newParam("groupid", $groupid))
  if `index`.isSome(): 
    params.add(newParam("index", $index))
  if `pickid`.isSome(): 
    params.add(newParam("pickid", $pickid))
  if `itemid`.isSome(): 
    params.add(newParam("itemid", $itemid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UploadTournamentPredictions/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `GetFantasyPlayerStatsV1`*(interfacename: AsyncIDOTA2Fantasy_205790, `FantasyLeagueID`=none(uint32), `StartTime`=none(uint32), `EndTime`=none(uint32), `MatchID`=none(uint64), `SeriesID`=none(uint32), `PlayerAccountID`=none(uint32)): Future[string] {.async.} = 
  ## `FantasyLeagueID` : uint32 — (Required) The fantasy league ID
  ## `StartTime` : uint32 — (Optional) An optional filter for minimum timestamp
  ## `EndTime` : uint32 — (Optional) An optional filter for maximum timestamp
  ## `MatchID` : uint64 — (Optional) An optional filter for a specific match
  ## `SeriesID` : uint32 — (Optional) An optional filter for a specific series
  ## `PlayerAccountID` : uint32 — (Optional) An optional filter for a specific player
  var params: seq[Param]
  if `FantasyLeagueID`.isSome(): 
    params.add(newParam("FantasyLeagueID", $FantasyLeagueID))
  if `StartTime`.isSome(): 
    params.add(newParam("StartTime", $StartTime))
  if `EndTime`.isSome(): 
    params.add(newParam("EndTime", $EndTime))
  if `MatchID`.isSome(): 
    params.add(newParam("MatchID", $MatchID))
  if `SeriesID`.isSome(): 
    params.add(newParam("SeriesID", $SeriesID))
  if `PlayerAccountID`.isSome(): 
    params.add(newParam("PlayerAccountID", $PlayerAccountID))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetFantasyPlayerStats/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerOfficialInfoV1`*(interfacename: AsyncIDOTA2Fantasy_205790, `accountid`=none(uint32)): Future[string] {.async.} = 
  ## `accountid` : uint32 — (Required) The account ID to look up
  var params: seq[Param]
  if `accountid`.isSome(): 
    params.add(newParam("accountid", $accountid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerOfficialInfo/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetProPlayerListV1`*(interfacename: AsyncIDOTA2Fantasy_205790): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetProPlayerList/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetRealtimeStatsV1`*(interfacename: AsyncIDOTA2MatchStats_205790, `server_steam_id`=none(uint64)): Future[string] {.async.} = 
  ## `server_steam_id` : uint64 — (Required) 
  var params: seq[Param]
  if `server_steam_id`.isSome(): 
    params.add(newParam("server_steam_id", $server_steam_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRealtimeStats/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetRealtimeStatsV1`*(interfacename: AsyncIDOTA2MatchStats_570, `server_steam_id`=none(uint64)): Future[string] {.async.} = 
  ## `server_steam_id` : uint64 — (Required) 
  var params: seq[Param]
  if `server_steam_id`.isSome(): 
    params.add(newParam("server_steam_id", $server_steam_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRealtimeStats/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetLeagueListingV1`*(interfacename: AsyncIDOTA2Match_205790): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetLeagueListing/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetLiveLeagueGamesV1`*(interfacename: AsyncIDOTA2Match_205790, `league_id`=none(uint32), `match_id`=none(uint64)): Future[string] {.async.} = 
  ## `league_id` : uint32 — (Optional) Only show matches of the specified league id
  ## `match_id` : uint64 — (Optional) Only show matches of the specified match id
  var params: seq[Param]
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetLiveLeagueGames/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetMatchDetailsV1`*(interfacename: AsyncIDOTA2Match_205790, `match_id`=none(uint64)): Future[string] {.async.} = 
  ## `match_id` : uint64 — (Required) Match id
  var params: seq[Param]
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchDetails/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetMatchHistoryV1`*(interfacename: AsyncIDOTA2Match_205790, `hero_id`=none(uint32), `game_mode`=none(uint32), `skill`=none(uint32), `min_players`=none(string), `account_id`=none(string), `league_id`=none(string), `start_at_match_id`=none(uint64), `matches_requested`=none(string)): Future[string] {.async.} = 
  ## `hero_id` : uint32 — (Optional) The ID of the hero that must be in the matches being queried
  ## `game_mode` : uint32 — (Optional) Which game mode to return matches for
  ## `skill` : uint32 — (Optional) The average skill range of the match, these can be [1-3] with lower numbers being lower skill. Ignored if an account ID is specified
  ## `min_players` : string — (Optional) Minimum number of human players that must be in a match for it to be returned
  ## `account_id` : string — (Optional) An account ID to get matches from. This will fail if the user has their match history hidden
  ## `league_id` : string — (Optional) The league ID to return games from
  ## `start_at_match_id` : uint64 — (Optional) The minimum match ID to start from
  ## `matches_requested` : string — (Optional) The number of requested matches to return
  var params: seq[Param]
  if `hero_id`.isSome(): 
    params.add(newParam("hero_id", $hero_id))
  if `game_mode`.isSome(): 
    params.add(newParam("game_mode", $game_mode))
  if `skill`.isSome(): 
    params.add(newParam("skill", $skill))
  if `min_players`.isSome(): 
    params.add(newParam("min_players", $min_players))
  if `account_id`.isSome(): 
    params.add(newParam("account_id", $account_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `start_at_match_id`.isSome(): 
    params.add(newParam("start_at_match_id", $start_at_match_id))
  if `matches_requested`.isSome(): 
    params.add(newParam("matches_requested", $matches_requested))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistory/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetMatchHistoryBySequenceNumV1`*(interfacename: AsyncIDOTA2Match_205790, `start_at_match_seq_num`=none(uint64), `matches_requested`=none(uint32)): Future[string] {.async.} = 
  ## `start_at_match_seq_num` : uint64 — (Optional) 
  ## `matches_requested` : uint32 — (Optional) 
  var params: seq[Param]
  if `start_at_match_seq_num`.isSome(): 
    params.add(newParam("start_at_match_seq_num", $start_at_match_seq_num))
  if `matches_requested`.isSome(): 
    params.add(newParam("matches_requested", $matches_requested))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistoryBySequenceNum/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTeamInfoByTeamIDV1`*(interfacename: AsyncIDOTA2Match_205790, `start_at_team_id`=none(uint64), `teams_requested`=none(uint32)): Future[string] {.async.} = 
  ## `start_at_team_id` : uint64 — (Optional) 
  ## `teams_requested` : uint32 — (Optional) 
  var params: seq[Param]
  if `start_at_team_id`.isSome(): 
    params.add(newParam("start_at_team_id", $start_at_team_id))
  if `teams_requested`.isSome(): 
    params.add(newParam("teams_requested", $teams_requested))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTeamInfoByTeamID/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTopLiveEventGameV1`*(interfacename: AsyncIDOTA2Match_205790, `partner`=none(int32)): Future[string] {.async.} = 
  ## `partner` : int32 — (Required) Which partner's games to use.
  var params: seq[Param]
  if `partner`.isSome(): 
    params.add(newParam("partner", $partner))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveEventGame/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTopLiveGameV1`*(interfacename: AsyncIDOTA2Match_205790, `partner`=none(int32)): Future[string] {.async.} = 
  ## `partner` : int32 — (Required) Which partner's games to use.
  var params: seq[Param]
  if `partner`.isSome(): 
    params.add(newParam("partner", $partner))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveGame/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTopWeekendTourneyGamesV1`*(interfacename: AsyncIDOTA2Match_205790, `partner`=none(int32), `home_division`=none(int32)): Future[string] {.async.} = 
  ## `partner` : int32 — (Required) Which partner's games to use.
  ## `home_division` : int32 — (Optional) Prefer matches from this division.
  var params: seq[Param]
  if `partner`.isSome(): 
    params.add(newParam("partner", $partner))
  if `home_division`.isSome(): 
    params.add(newParam("home_division", $home_division))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopWeekendTourneyGames/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentPlayerStatsV1`*(interfacename: AsyncIDOTA2Match_205790, `account_id`=none(string), `league_id`=none(string), `hero_id`=none(string), `time_frame`=none(string), `match_id`=none(uint64), `phase_id`=none(uint32)): Future[string] {.async.} = 
  ## `account_id` : string — (Required) 
  ## `league_id` : string — (Optional) 
  ## `hero_id` : string — (Optional) 
  ## `time_frame` : string — (Optional) 
  ## `match_id` : uint64 — (Optional) 
  ## `phase_id` : uint32 — (Optional) 
  var params: seq[Param]
  if `account_id`.isSome(): 
    params.add(newParam("account_id", $account_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `hero_id`.isSome(): 
    params.add(newParam("hero_id", $hero_id))
  if `time_frame`.isSome(): 
    params.add(newParam("time_frame", $time_frame))
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  if `phase_id`.isSome(): 
    params.add(newParam("phase_id", $phase_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentPlayerStatsV2`*(interfacename: AsyncIDOTA2Match_205790, `account_id`=none(string), `league_id`=none(string), `hero_id`=none(string), `time_frame`=none(string), `match_id`=none(uint64), `phase_id`=none(uint32)): Future[string] {.async.} = 
  ## `account_id` : string — (Required) 
  ## `league_id` : string — (Optional) 
  ## `hero_id` : string — (Optional) 
  ## `time_frame` : string — (Optional) 
  ## `match_id` : uint64 — (Optional) 
  ## `phase_id` : uint32 — (Optional) 
  var params: seq[Param]
  if `account_id`.isSome(): 
    params.add(newParam("account_id", $account_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `hero_id`.isSome(): 
    params.add(newParam("hero_id", $hero_id))
  if `time_frame`.isSome(): 
    params.add(newParam("time_frame", $time_frame))
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  if `phase_id`.isSome(): 
    params.add(newParam("phase_id", $phase_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v2/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetLiveLeagueGamesV1`*(interfacename: AsyncIDOTA2Match_570, `league_id`=none(uint32), `match_id`=none(uint64), `dpc`=none(bool)): Future[string] {.async.} = 
  ## `league_id` : uint32 — (Optional) Only show matches of the specified league id
  ## `match_id` : uint64 — (Optional) Only show matches of the specified match id
  ## `dpc` : bool — (Optional) Only show matches that are part of the DPC
  var params: seq[Param]
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  if `dpc`.isSome(): 
    params.add(newParam("dpc", $dpc))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetLiveLeagueGames/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetMatchDetailsV1`*(interfacename: AsyncIDOTA2Match_570, `match_id`=none(uint64), `include_persona_names`=none(bool)): Future[string] {.async.} = 
  ## `match_id` : uint64 — (Required) Match id
  ## `include_persona_names` : bool — (Optional) Include persona names as part of the response
  var params: seq[Param]
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  if `include_persona_names`.isSome(): 
    params.add(newParam("include_persona_names", $include_persona_names))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchDetails/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetMatchHistoryV1`*(interfacename: AsyncIDOTA2Match_570, `hero_id`=none(uint32), `game_mode`=none(uint32), `skill`=none(uint32), `min_players`=none(string), `account_id`=none(string), `league_id`=none(string), `start_at_match_id`=none(uint64), `matches_requested`=none(string)): Future[string] {.async.} = 
  ## `hero_id` : uint32 — (Optional) The ID of the hero that must be in the matches being queried
  ## `game_mode` : uint32 — (Optional) Which game mode to return matches for
  ## `skill` : uint32 — (Optional) The average skill range of the match, these can be [1-3] with lower numbers being lower skill. Ignored if an account ID is specified
  ## `min_players` : string — (Optional) Minimum number of human players that must be in a match for it to be returned
  ## `account_id` : string — (Optional) An account ID to get matches from. This will fail if the user has their match history hidden
  ## `league_id` : string — (Optional) The league ID to return games from
  ## `start_at_match_id` : uint64 — (Optional) The minimum match ID to start from
  ## `matches_requested` : string — (Optional) The number of requested matches to return
  var params: seq[Param]
  if `hero_id`.isSome(): 
    params.add(newParam("hero_id", $hero_id))
  if `game_mode`.isSome(): 
    params.add(newParam("game_mode", $game_mode))
  if `skill`.isSome(): 
    params.add(newParam("skill", $skill))
  if `min_players`.isSome(): 
    params.add(newParam("min_players", $min_players))
  if `account_id`.isSome(): 
    params.add(newParam("account_id", $account_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `start_at_match_id`.isSome(): 
    params.add(newParam("start_at_match_id", $start_at_match_id))
  if `matches_requested`.isSome(): 
    params.add(newParam("matches_requested", $matches_requested))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistory/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetMatchHistoryBySequenceNumV1`*(interfacename: AsyncIDOTA2Match_570, `start_at_match_seq_num`=none(uint64), `matches_requested`=none(uint32)): Future[string] {.async.} = 
  ## `start_at_match_seq_num` : uint64 — (Optional) 
  ## `matches_requested` : uint32 — (Optional) 
  var params: seq[Param]
  if `start_at_match_seq_num`.isSome(): 
    params.add(newParam("start_at_match_seq_num", $start_at_match_seq_num))
  if `matches_requested`.isSome(): 
    params.add(newParam("matches_requested", $matches_requested))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistoryBySequenceNum/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTeamInfoByTeamIDV1`*(interfacename: AsyncIDOTA2Match_570, `start_at_team_id`=none(uint64), `teams_requested`=none(uint32)): Future[string] {.async.} = 
  ## `start_at_team_id` : uint64 — (Optional) 
  ## `teams_requested` : uint32 — (Optional) 
  var params: seq[Param]
  if `start_at_team_id`.isSome(): 
    params.add(newParam("start_at_team_id", $start_at_team_id))
  if `teams_requested`.isSome(): 
    params.add(newParam("teams_requested", $teams_requested))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTeamInfoByTeamID/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTopLiveEventGameV1`*(interfacename: AsyncIDOTA2Match_570, `partner`=none(int32)): Future[string] {.async.} = 
  ## `partner` : int32 — (Required) Which partner's games to use.
  var params: seq[Param]
  if `partner`.isSome(): 
    params.add(newParam("partner", $partner))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveEventGame/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTopLiveGameV1`*(interfacename: AsyncIDOTA2Match_570, `partner`=none(int32)): Future[string] {.async.} = 
  ## `partner` : int32 — (Required) Which partner's games to use.
  var params: seq[Param]
  if `partner`.isSome(): 
    params.add(newParam("partner", $partner))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveGame/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTopWeekendTourneyGamesV1`*(interfacename: AsyncIDOTA2Match_570, `partner`=none(int32), `home_division`=none(int32)): Future[string] {.async.} = 
  ## `partner` : int32 — (Required) Which partner's games to use.
  ## `home_division` : int32 — (Optional) Prefer matches from this division.
  var params: seq[Param]
  if `partner`.isSome(): 
    params.add(newParam("partner", $partner))
  if `home_division`.isSome(): 
    params.add(newParam("home_division", $home_division))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopWeekendTourneyGames/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentPlayerStatsV1`*(interfacename: AsyncIDOTA2Match_570, `account_id`=none(string), `league_id`=none(string), `hero_id`=none(string), `time_frame`=none(string), `match_id`=none(uint64)): Future[string] {.async.} = 
  ## `account_id` : string — (Required) 
  ## `league_id` : string — (Optional) 
  ## `hero_id` : string — (Optional) 
  ## `time_frame` : string — (Optional) 
  ## `match_id` : uint64 — (Optional) 
  var params: seq[Param]
  if `account_id`.isSome(): 
    params.add(newParam("account_id", $account_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `hero_id`.isSome(): 
    params.add(newParam("hero_id", $hero_id))
  if `time_frame`.isSome(): 
    params.add(newParam("time_frame", $time_frame))
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentPlayerStatsV2`*(interfacename: AsyncIDOTA2Match_570, `account_id`=none(string), `league_id`=none(string), `hero_id`=none(string), `time_frame`=none(string), `match_id`=none(uint64), `phase_id`=none(uint32)): Future[string] {.async.} = 
  ## `account_id` : string — (Required) 
  ## `league_id` : string — (Optional) 
  ## `hero_id` : string — (Optional) 
  ## `time_frame` : string — (Optional) 
  ## `match_id` : uint64 — (Optional) 
  ## `phase_id` : uint32 — (Optional) 
  var params: seq[Param]
  if `account_id`.isSome(): 
    params.add(newParam("account_id", $account_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  if `hero_id`.isSome(): 
    params.add(newParam("hero_id", $hero_id))
  if `time_frame`.isSome(): 
    params.add(newParam("time_frame", $time_frame))
  if `match_id`.isSome(): 
    params.add(newParam("match_id", $match_id))
  if `phase_id`.isSome(): 
    params.add(newParam("phase_id", $phase_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v2/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetBroadcasterInfoV1`*(interfacename: AsyncIDOTA2StreamSystem_205790, `broadcaster_steam_id`=none(uint64), `league_id`=none(uint32)): Future[string] {.async.} = 
  ## `broadcaster_steam_id` : uint64 — (Required) 64-bit Steam ID of the broadcaster
  ## `league_id` : uint32 — (Optional) LeagueID to use if we aren't in a lobby
  var params: seq[Param]
  if `broadcaster_steam_id`.isSome(): 
    params.add(newParam("broadcaster_steam_id", $broadcaster_steam_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBroadcasterInfo/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetBroadcasterInfoV1`*(interfacename: AsyncIDOTA2StreamSystem_570, `broadcaster_steam_id`=none(uint64), `league_id`=none(uint32)): Future[string] {.async.} = 
  ## `broadcaster_steam_id` : uint64 — (Required) 64-bit Steam ID of the broadcaster
  ## `league_id` : uint32 — (Optional) LeagueID to use if we aren't in a lobby
  var params: seq[Param]
  if `broadcaster_steam_id`.isSome(): 
    params.add(newParam("broadcaster_steam_id", $broadcaster_steam_id))
  if `league_id`.isSome(): 
    params.add(newParam("league_id", $league_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBroadcasterInfo/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `ClaimBadgeRewardV1`*(interfacename: AsyncIDOTA2Ticket_205790, `BadgeID`=none(string), `ValidBadgeType1`=none(uint32), `ValidBadgeType2`=none(uint32), `ValidBadgeType3`=none(uint32)): Future[string] {.async.} = 
  ## `BadgeID` : string — (Required) The Badge ID
  ## `ValidBadgeType1` : uint32 — (Required) Valid Badge Type 1
  ## `ValidBadgeType2` : uint32 — (Required) Valid Badge Type 2
  ## `ValidBadgeType3` : uint32 — (Required) Valid Badge Type 3
  var params: seq[Param]
  if `BadgeID`.isSome(): 
    params.add(newParam("BadgeID", $BadgeID))
  if `ValidBadgeType1`.isSome(): 
    params.add(newParam("ValidBadgeType1", $ValidBadgeType1))
  if `ValidBadgeType2`.isSome(): 
    params.add(newParam("ValidBadgeType2", $ValidBadgeType2))
  if `ValidBadgeType3`.isSome(): 
    params.add(newParam("ValidBadgeType3", $ValidBadgeType3))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/ClaimBadgeReward/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSteamIDForBadgeIDV1`*(interfacename: AsyncIDOTA2Ticket_205790, `BadgeID`=none(string)): Future[string] {.async.} = 
  ## `BadgeID` : string — (Required) The badge ID
  var params: seq[Param]
  if `BadgeID`.isSome(): 
    params.add(newParam("BadgeID", $BadgeID))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamIDForBadgeID/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `SetSteamAccountPurchasedV1`*(interfacename: AsyncIDOTA2Ticket_205790, `steamid`=none(uint64), `BadgeType`=none(uint32)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The 64-bit Steam ID
  ## `BadgeType` : uint32 — (Required) Badge Type
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `BadgeType`.isSome(): 
    params.add(newParam("BadgeType", $BadgeType))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamAccountPurchased/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `SteamAccountValidForBadgeTypeV1`*(interfacename: AsyncIDOTA2Ticket_205790, `steamid`=none(uint64), `ValidBadgeType1`=none(uint32), `ValidBadgeType2`=none(uint32), `ValidBadgeType3`=none(uint32)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The 64-bit Steam ID
  ## `ValidBadgeType1` : uint32 — (Required) Valid Badge Type 1
  ## `ValidBadgeType2` : uint32 — (Required) Valid Badge Type 2
  ## `ValidBadgeType3` : uint32 — (Required) Valid Badge Type 3
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `ValidBadgeType1`.isSome(): 
    params.add(newParam("ValidBadgeType1", $ValidBadgeType1))
  if `ValidBadgeType2`.isSome(): 
    params.add(newParam("ValidBadgeType2", $ValidBadgeType2))
  if `ValidBadgeType3`.isSome(): 
    params.add(newParam("ValidBadgeType3", $ValidBadgeType3))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/SteamAccountValidForBadgeType/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `SetSteamAccountPurchasedV1`*(interfacename: AsyncIDOTA2Ticket_570, `SteamID`=none(uint64), `BadgeType`=none(uint32)): Future[string] {.async.} = 
  ## `SteamID` : uint64 — (Required) The 64-bit Steam ID
  ## `BadgeType` : uint32 — (Required) Badge Type
  var params: seq[Param]
  if `SteamID`.isSome(): 
    params.add(newParam("SteamID", $SteamID))
  if `BadgeType`.isSome(): 
    params.add(newParam("BadgeType", $BadgeType))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamAccountPurchased/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `SteamAccountValidForBadgeTypeV1`*(interfacename: AsyncIDOTA2Ticket_570, `SteamID`=none(uint64), `ValidBadgeType1`=none(uint32), `ValidBadgeType2`=none(uint32), `ValidBadgeType3`=none(uint32)): Future[string] {.async.} = 
  ## `SteamID` : uint64 — (Required) The 64-bit Steam ID
  ## `ValidBadgeType1` : uint32 — (Required) Valid Badge Type 1
  ## `ValidBadgeType2` : uint32 — (Required) Valid Badge Type 2
  ## `ValidBadgeType3` : uint32 — (Required) Valid Badge Type 3
  var params: seq[Param]
  if `SteamID`.isSome(): 
    params.add(newParam("SteamID", $SteamID))
  if `ValidBadgeType1`.isSome(): 
    params.add(newParam("ValidBadgeType1", $ValidBadgeType1))
  if `ValidBadgeType2`.isSome(): 
    params.add(newParam("ValidBadgeType2", $ValidBadgeType2))
  if `ValidBadgeType3`.isSome(): 
    params.add(newParam("ValidBadgeType3", $ValidBadgeType3))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/SteamAccountValidForBadgeType/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetEventStatsForAccountV1`*(interfacename: AsyncIEconDOTA2_205790, `eventid`=none(uint32), `accountid`=none(uint32), `language`=none(string)): Future[string] {.async.} = 
  ## `eventid` : uint32 — (Required) The League ID of the compendium you're looking for.
  ## `accountid` : uint32 — (Required) The account ID to look up.
  ## `language` : string — (Optional) The language to provide hero names in.
  var params: seq[Param]
  if `eventid`.isSome(): 
    params.add(newParam("eventid", $eventid))
  if `accountid`.isSome(): 
    params.add(newParam("accountid", $accountid))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEventStatsForAccount/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGameItemsV1`*(interfacename: AsyncIEconDOTA2_205790, `language`=none(string)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to provide item names in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetHeroesV1`*(interfacename: AsyncIEconDOTA2_205790, `language`=none(string), `itemizedonly`=none(bool)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to provide hero names in.
  ## `itemizedonly` : bool — (Optional) Return a list of itemized heroes only.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `itemizedonly`.isSome(): 
    params.add(newParam("itemizedonly", $itemizedonly))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetHeroes/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetItemIconPathV1`*(interfacename: AsyncIEconDOTA2_205790, `iconname`=none(string), `icontype`=none(uint32)): Future[string] {.async.} = 
  ## `iconname` : string — (Required) The item icon name to get the CDN path of
  ## `icontype` : uint32 — (Optional) The type of image you want. 0 = normal, 1 = large, 2 = ingame
  var params: seq[Param]
  if `iconname`.isSome(): 
    params.add(newParam("iconname", $iconname))
  if `icontype`.isSome(): 
    params.add(newParam("icontype", $icontype))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemIconPath/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetRaritiesV1`*(interfacename: AsyncIEconDOTA2_205790, `language`=none(string)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to provide rarity names in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRarities/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentPrizePoolV1`*(interfacename: AsyncIEconDOTA2_205790, `leagueid`=none(uint32)): Future[string] {.async.} = 
  ## `leagueid` : uint32 — (Optional) The ID of the league to get the prize pool of
  var params: seq[Param]
  if `leagueid`.isSome(): 
    params.add(newParam("leagueid", $leagueid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPrizePool/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetEventStatsForAccountV1`*(interfacename: AsyncIEconDOTA2_570, `eventid`=none(uint32), `accountid`=none(uint32), `language`=none(string)): Future[string] {.async.} = 
  ## `eventid` : uint32 — (Required) The Event ID of the event you're looking for.
  ## `accountid` : uint32 — (Required) The account ID to look up.
  ## `language` : string — (Optional) The language to provide hero names in.
  var params: seq[Param]
  if `eventid`.isSome(): 
    params.add(newParam("eventid", $eventid))
  if `accountid`.isSome(): 
    params.add(newParam("accountid", $accountid))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEventStatsForAccount/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGameItemsV1`*(interfacename: AsyncIEconDOTA2_570, `language`=none(string)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to provide item names in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetHeroesV1`*(interfacename: AsyncIEconDOTA2_570, `language`=none(string), `itemizedonly`=none(bool)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to provide hero names in.
  ## `itemizedonly` : bool — (Optional) Return a list of itemized heroes only.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `itemizedonly`.isSome(): 
    params.add(newParam("itemizedonly", $itemizedonly))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetHeroes/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetItemCreatorsV1`*(interfacename: AsyncIEconDOTA2_570, `itemdef`=none(uint32)): Future[string] {.async.} = 
  ## `itemdef` : uint32 — (Required) The item definition to get creator information for.
  var params: seq[Param]
  if `itemdef`.isSome(): 
    params.add(newParam("itemdef", $itemdef))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemCreators/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetItemWorkshopPublishedFileIDsV1`*(interfacename: AsyncIEconDOTA2_570, `itemdef`=none(uint32)): Future[string] {.async.} = 
  ## `itemdef` : uint32 — (Required) The item definition to get published file ids for.
  var params: seq[Param]
  if `itemdef`.isSome(): 
    params.add(newParam("itemdef", $itemdef))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemWorkshopPublishedFileIDs/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetRaritiesV1`*(interfacename: AsyncIEconDOTA2_570, `language`=none(string)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to provide rarity names in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRarities/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentPrizePoolV1`*(interfacename: AsyncIEconDOTA2_570, `leagueid`=none(uint32)): Future[string] {.async.} = 
  ## `leagueid` : uint32 — (Optional) The ID of the league to get the prize pool of
  var params: seq[Param]
  if `leagueid`.isSome(): 
    params.add(newParam("leagueid", $leagueid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPrizePool/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_1046930, `steamid`=none(uint64)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: AsyncIEconItems_1269260, `steamid`=none(uint64), `class_id`=none(uint32)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `class_id` : uint32 — (Required) Return items equipped for this class id
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `class_id`.isSome(): 
    params.add(newParam("class_id", $class_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: AsyncIEconItems_205790, `steamid`=none(uint64), `class_id`=none(uint32)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `class_id` : uint32 — (Required) Return items equipped for this class id
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `class_id`.isSome(): 
    params.add(newParam("class_id", $class_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_205790, `steamid`=none(uint64)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaURLV1`*(interfacename: AsyncIEconItems_205790): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaURL/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: AsyncIEconItems_205790, `language`=none(string)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to results in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_221540, `steamid`=none(uint64)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_238460, `steamid`=none(uint64)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_440, `steamid`=none(uint64)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaV1`*(interfacename: AsyncIEconItems_440, `language`=none(string)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to return the names in. Defaults to returning string keys.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchema/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaItemsV1`*(interfacename: AsyncIEconItems_440, `language`=none(string), `start`=none(int32)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to return the names in. Defaults to returning string keys.
  ## `start` : int32 — (Optional) The first item id to return. Defaults to 0. Response will indicate next value to query if applicable.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `start`.isSome(): 
    params.add(newParam("start", $start))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaOverviewV1`*(interfacename: AsyncIEconItems_440, `language`=none(string)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to return the names in. Defaults to returning string keys.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaOverview/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaURLV1`*(interfacename: AsyncIEconItems_440): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaURL/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: AsyncIEconItems_440, `language`=none(string)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to results in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetStoreStatusV1`*(interfacename: AsyncIEconItems_440): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreStatus/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: AsyncIEconItems_570, `SteamID`=none(uint64), `class_id`=none(uint32)): Future[string] {.async.} = 
  ## `SteamID` : uint64 — (Required) The Steam ID to fetch items for
  ## `class_id` : uint32 — (Required) Return items equipped for this class id
  var params: seq[Param]
  if `SteamID`.isSome(): 
    params.add(newParam("SteamID", $SteamID))
  if `class_id`.isSome(): 
    params.add(newParam("class_id", $class_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_570, `SteamID`=none(uint64)): Future[string] {.async.} = 
  ## `SteamID` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `SteamID`.isSome(): 
    params.add(newParam("SteamID", $SteamID))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: AsyncIEconItems_570, `language`=none(string)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to results in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: AsyncIEconItems_583950, `steamid`=none(uint64), `class_id`=none(uint32)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `class_id` : uint32 — (Required) Return items equipped for this class id
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `class_id`.isSome(): 
    params.add(newParam("class_id", $class_id))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_620, `steamid`=none(uint64)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaV1`*(interfacename: AsyncIEconItems_620, `language`=none(string)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to return the names in. Defaults to returning string keys.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchema/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_730, `steamid`=none(uint64)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaV2`*(interfacename: AsyncIEconItems_730, `language`=none(string)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to return the names in. Defaults to returning string keys.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchema/v2/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaURLV2`*(interfacename: AsyncIEconItems_730): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaURL/v2/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: AsyncIEconItems_730, `language`=none(string)): Future[string] {.async.} = 
  ## `language` : string — (Optional) The language to results in.
  var params: seq[Param]
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: AsyncIGCVersion_1046930): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: AsyncIGCVersion_1046930): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: AsyncIGCVersion_1269260): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: AsyncIGCVersion_1269260): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: AsyncIGCVersion_205790): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: AsyncIGCVersion_205790): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: AsyncIGCVersion_440): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: AsyncIGCVersion_440): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: AsyncIGCVersion_570): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: AsyncIGCVersion_570): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: AsyncIGCVersion_583950): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: AsyncIGCVersion_583950): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: AsyncIGCVersion_730): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetBucketizedDataV1`*(interfacename: AsyncIPortal2Leaderboards_620, `leaderboardName`=none(string)): Future[string] {.async.} = 
  ## `leaderboardName` : string — (Required) The leaderboard name to fetch data for.
  var params: seq[Param]
  if `leaderboardName`.isSome(): 
    params.add(newParam("leaderboardName", $leaderboardName))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBucketizedData/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetAppListV1`*(interfacename: AsyncISteamApps): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAppList/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetAppListV2`*(interfacename: AsyncISteamApps): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAppList/v2/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSDRConfigV1`*(interfacename: AsyncISteamApps, `appid`=none(uint32)): Future[string] {.async.} = 
  ## `appid` : uint32 — (Required) AppID of game
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSDRConfig/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServersAtAddressV1`*(interfacename: AsyncISteamApps, `addr`=none(string)): Future[string] {.async.} = 
  ## `addr` : string — (Required) IP or IP:queryport to list
  var params: seq[Param]
  if `addr`.isSome(): 
    params.add(newParam("addr", $addr))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServersAtAddress/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `UpToDateCheckV1`*(interfacename: AsyncISteamApps, `appid`=none(uint32), `version`=none(uint32)): Future[string] {.async.} = 
  ## `appid` : uint32 — (Required) AppID of game
  ## `version` : uint32 — (Required) The installed version of the game
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `version`.isSome(): 
    params.add(newParam("version", $version))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/UpToDateCheck/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `ViewerHeartbeatV1`*(interfacename: AsyncISteamBroadcast, `steamid`=none(uint64), `sessionid`=none(uint64), `token`=none(uint64), `stream`=none(int32)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) Steam ID of the broadcaster
  ## `sessionid` : uint64 — (Required) Broadcast Session ID
  ## `token` : uint64 — (Required) Viewer token
  ## `stream` : int32 — (Optional) video stream representation watching
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `sessionid`.isSome(): 
    params.add(newParam("sessionid", $sessionid))
  if `token`.isSome(): 
    params.add(newParam("token", $token))
  if `stream`.isSome(): 
    params.add(newParam("stream", $stream))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/ViewerHeartbeat/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `SetClientFiltersV1`*(interfacename: AsyncISteamCDN, `key`=none(string), `cdnname`=none(string), `allowedipblocks`=none(string), `allowedasns`=none(string), `allowedipcountries`=none(string)): Future[string] {.async.} = 
  ## `key` : string — (Required) access key
  ## `cdnname` : string — (Required) Steam name of CDN property
  ## `allowedipblocks` : string — (Optional) comma-separated list of allowed IP address blocks in CIDR format - blank for not used
  ## `allowedasns` : string — (Optional) comma-separated list of allowed client network AS numbers - blank for not used
  ## `allowedipcountries` : string — (Optional) comma-separated list of allowed client IP country codes in ISO 3166-1 format - blank for not used
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `cdnname`.isSome(): 
    params.add(newParam("cdnname", $cdnname))
  if `allowedipblocks`.isSome(): 
    params.add(newParam("allowedipblocks", $allowedipblocks))
  if `allowedasns`.isSome(): 
    params.add(newParam("allowedasns", $allowedasns))
  if `allowedipcountries`.isSome(): 
    params.add(newParam("allowedipcountries", $allowedipcountries))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetClientFilters/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `SetPerformanceStatsV1`*(interfacename: AsyncISteamCDN, `key`=none(string), `cdnname`=none(string), `mbps_sent`=none(uint32), `mbps_recv`=none(uint32), `cpu_percent`=none(uint32), `cache_hit_percent`=none(uint32)): Future[string] {.async.} = 
  ## `key` : string — (Required) access key
  ## `cdnname` : string — (Required) Steam name of CDN property
  ## `mbps_sent` : uint32 — (Optional) Outgoing network traffic in Mbps
  ## `mbps_recv` : uint32 — (Optional) Incoming network traffic in Mbps
  ## `cpu_percent` : uint32 — (Optional) Percent CPU load
  ## `cache_hit_percent` : uint32 — (Optional) Percent cache hits
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `cdnname`.isSome(): 
    params.add(newParam("cdnname", $cdnname))
  if `mbps_sent`.isSome(): 
    params.add(newParam("mbps_sent", $mbps_sent))
  if `mbps_recv`.isSome(): 
    params.add(newParam("mbps_recv", $mbps_recv))
  if `cpu_percent`.isSome(): 
    params.add(newParam("cpu_percent", $cpu_percent))
  if `cache_hit_percent`.isSome(): 
    params.add(newParam("cache_hit_percent", $cache_hit_percent))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetPerformanceStats/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `GetCMListV1`*(interfacename: AsyncISteamDirectory, `cellid`=none(uint32), `maxcount`=none(uint32)): Future[string] {.async.} = 
  ## `cellid` : uint32 — (Required) Client's Steam cell ID
  ## `maxcount` : uint32 — (Optional) Max number of servers to return
  var params: seq[Param]
  if `cellid`.isSome(): 
    params.add(newParam("cellid", $cellid))
  if `maxcount`.isSome(): 
    params.add(newParam("maxcount", $maxcount))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCMList/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetCMListForConnectV1`*(interfacename: AsyncISteamDirectory, `cellid`=none(uint32), `cmtype`=none(string), `realm`=none(string), `maxcount`=none(uint32)): Future[string] {.async.} = 
  ## `cellid` : uint32 — (Optional) Client's Steam cell ID, uses IP location if blank
  ## `cmtype` : string — (Optional) Optional CM type filter
  ## `realm` : string — (Optional) Optional Steam Realm filter
  ## `maxcount` : uint32 — (Optional) Max number of servers to return
  var params: seq[Param]
  if `cellid`.isSome(): 
    params.add(newParam("cellid", $cellid))
  if `cmtype`.isSome(): 
    params.add(newParam("cmtype", $cmtype))
  if `realm`.isSome(): 
    params.add(newParam("realm", $realm))
  if `maxcount`.isSome(): 
    params.add(newParam("maxcount", $maxcount))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCMListForConnect/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSteamPipeDomainsV1`*(interfacename: AsyncISteamDirectory): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamPipeDomains/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetAssetClassInfoV1`*(interfacename: AsyncISteamEconomy, `appid`=none(uint32), `language`=none(string), `class_count`=none(uint32), `classid0`=none(uint64), `instanceid0`=none(uint64)): Future[string] {.async.} = 
  ## `appid` : uint32 — (Required) Must be a steam economy app.
  ## `language` : string — (Optional) The user's local language
  ## `class_count` : uint32 — (Required) Number of classes requested. Must be at least one.
  ## `classid0` : uint64 — (Required) Class ID of the nth class.
  ## `instanceid0` : uint64 — (Optional) Instance ID of the nth class.
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `class_count`.isSome(): 
    params.add(newParam("class_count", $class_count))
  if `classid0`.isSome(): 
    params.add(newParam("classid0", $classid0))
  if `instanceid0`.isSome(): 
    params.add(newParam("instanceid0", $instanceid0))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAssetClassInfo/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetAssetPricesV1`*(interfacename: AsyncISteamEconomy, `appid`=none(uint32), `currency`=none(string), `language`=none(string)): Future[string] {.async.} = 
  ## `appid` : uint32 — (Required) Must be a steam economy app.
  ## `currency` : string — (Optional) The currency to filter for
  ## `language` : string — (Optional) The user's local language
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `currency`.isSome(): 
    params.add(newParam("currency", $currency))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAssetPrices/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetNewsForAppV1`*(interfacename: AsyncISteamNews, `appid`=none(uint32), `maxlength`=none(uint32), `enddate`=none(uint32), `count`=none(uint32), `tags`=none(string)): Future[string] {.async.} = 
  ## `appid` : uint32 — (Required) AppID to retrieve news for
  ## `maxlength` : uint32 — (Optional) Maximum length for the content to return, if this is 0 the full content is returned, if it's less then a blurb is generated to fit.
  ## `enddate` : uint32 — (Optional) Retrieve posts earlier than this date (unix epoch timestamp)
  ## `count` : uint32 — (Optional) # of posts to retrieve (default 20)
  ## `tags` : string — (Optional) Comma-separated list of tags to filter by (e.g. 'patchnodes')
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `maxlength`.isSome(): 
    params.add(newParam("maxlength", $maxlength))
  if `enddate`.isSome(): 
    params.add(newParam("enddate", $enddate))
  if `count`.isSome(): 
    params.add(newParam("count", $count))
  if `tags`.isSome(): 
    params.add(newParam("tags", $tags))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNewsForApp/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetNewsForAppV2`*(interfacename: AsyncISteamNews, `appid`=none(uint32), `maxlength`=none(uint32), `enddate`=none(uint32), `count`=none(uint32), `feeds`=none(string), `tags`=none(string)): Future[string] {.async.} = 
  ## `appid` : uint32 — (Required) AppID to retrieve news for
  ## `maxlength` : uint32 — (Optional) Maximum length for the content to return, if this is 0 the full content is returned, if it's less then a blurb is generated to fit.
  ## `enddate` : uint32 — (Optional) Retrieve posts earlier than this date (unix epoch timestamp)
  ## `count` : uint32 — (Optional) # of posts to retrieve (default 20)
  ## `feeds` : string — (Optional) Comma-separated list of feed names to return news for
  ## `tags` : string — (Optional) Comma-separated list of tags to filter by (e.g. 'patchnodes')
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `maxlength`.isSome(): 
    params.add(newParam("maxlength", $maxlength))
  if `enddate`.isSome(): 
    params.add(newParam("enddate", $enddate))
  if `count`.isSome(): 
    params.add(newParam("count", $count))
  if `feeds`.isSome(): 
    params.add(newParam("feeds", $feeds))
  if `tags`.isSome(): 
    params.add(newParam("tags", $tags))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNewsForApp/v2/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetCollectionDetailsV1`*(interfacename: AsyncISteamRemoteStorage, `collectioncount`=none(uint32), `publishedfileids`=none(seq[uint64])): Future[string] {.async.} = 
  ## `collectioncount` : uint32 — (Required) Number of collections being requested
  ## `publishedfileids[0]` : uint64 — (Required) collection ids to get the details for
  var params: seq[Param]
  if `collectioncount`.isSome(): 
    params.add(newParam("collectioncount", $collectioncount))
  if `publishedfileids`.isSome(): 
    ## Params for seq[]
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCollectionDetails/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `GetPublishedFileDetailsV1`*(interfacename: AsyncISteamRemoteStorage, `itemcount`=none(uint32), `publishedfileids`=none(seq[uint64])): Future[string] {.async.} = 
  ## `itemcount` : uint32 — (Required) Number of items being requested
  ## `publishedfileids[0]` : uint64 — (Required) published file id to look up
  var params: seq[Param]
  if `itemcount`.isSome(): 
    params.add(newParam("itemcount", $itemcount))
  if `publishedfileids`.isSome(): 
    ## Params for seq[]
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPublishedFileDetails/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `GetUGCFileDetailsV1`*(interfacename: AsyncISteamRemoteStorage, `steamid`=none(uint64), `ugcid`=none(uint64), `appid`=none(uint32)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Optional) If specified, only returns details if the file is owned by the SteamID specified
  ## `ugcid` : uint64 — (Required) ID of UGC file to get info for
  ## `appid` : uint32 — (Required) appID of product
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `ugcid`.isSome(): 
    params.add(newParam("ugcid", $ugcid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUGCFileDetails/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetFriendListV1`*(interfacename: AsyncISteamUser, `key`=none(string), `steamid`=none(uint64), `relationship`=none(string)): Future[string] {.async.} = 
  ## `key` : string — (Required) access key
  ## `steamid` : uint64 — (Required) SteamID of user
  ## `relationship` : string — (Optional) relationship type (ex: friend)
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `relationship`.isSome(): 
    params.add(newParam("relationship", $relationship))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetFriendList/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerBansV1`*(interfacename: AsyncISteamUser, `key`=none(string), `steamids`=none(string)): Future[string] {.async.} = 
  ## `key` : string — (Required) access key
  ## `steamids` : string — (Required) Comma-delimited list of SteamIDs
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamids`.isSome(): 
    params.add(newParam("steamids", $steamids))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerBans/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerSummariesV1`*(interfacename: AsyncISteamUser, `key`=none(string), `steamids`=none(string)): Future[string] {.async.} = 
  ## `key` : string — (Required) access key
  ## `steamids` : string — (Required) Comma-delimited list of SteamIDs
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamids`.isSome(): 
    params.add(newParam("steamids", $steamids))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerSummaries/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerSummariesV2`*(interfacename: AsyncISteamUser, `key`=none(string), `steamids`=none(string)): Future[string] {.async.} = 
  ## `key` : string — (Required) access key
  ## `steamids` : string — (Required) Comma-delimited list of SteamIDs (max: 100)
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamids`.isSome(): 
    params.add(newParam("steamids", $steamids))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerSummaries/v2/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetUserGroupListV1`*(interfacename: AsyncISteamUser, `key`=none(string), `steamid`=none(uint64)): Future[string] {.async.} = 
  ## `key` : string — (Required) access key
  ## `steamid` : uint64 — (Required) SteamID of user
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserGroupList/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `ResolveVanityURLV1`*(interfacename: AsyncISteamUser, `key`=none(string), `vanityurl`=none(string), `url_type`=none(int32)): Future[string] {.async.} = 
  ## `key` : string — (Required) access key
  ## `vanityurl` : string — (Required) The vanity URL to get a SteamID for
  ## `url_type` : int32 — (Optional) The type of vanity URL. 1 (default): Individual profile, 2: Group, 3: Official game group
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `vanityurl`.isSome(): 
    params.add(newParam("vanityurl", $vanityurl))
  if `url_type`.isSome(): 
    params.add(newParam("url_type", $url_type))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/ResolveVanityURL/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `AuthenticateUserV1`*(interfacename: AsyncISteamUserAuth, `steamid`=none(uint64), `sessionkey`=none(Rawbinary), `encrypted_loginkey`=none(Rawbinary)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) Should be the users steamid, unencrypted.
  ## `sessionkey` : Rawbinary — (Required) Should be a 32 byte random blob of data, which is then encrypted with RSA using the Steam system's public key.  Randomness is important here for security.
  ## `encrypted_loginkey` : Rawbinary — (Required) Should be the users hashed loginkey, AES encrypted with the sessionkey.
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `sessionkey`.isSome(): 
    params.add(newParam("sessionkey", $sessionkey))
  if `encrypted_loginkey`.isSome(): 
    params.add(newParam("encrypted_loginkey", $encrypted_loginkey))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/AuthenticateUser/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `AuthenticateUserTicketV1`*(interfacename: AsyncISteamUserAuth, `key`=none(string), `appid`=none(uint32), `ticket`=none(string)): Future[string] {.async.} = 
  ## `key` : string — (Required) access key
  ## `appid` : uint32 — (Required) appid of game
  ## `ticket` : string — (Required) Ticket from GetAuthSessionTicket.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `ticket`.isSome(): 
    params.add(newParam("ticket", $ticket))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/AuthenticateUserTicket/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTokenDetailsV1`*(interfacename: AsyncISteamUserOAuth, `access_token`=none(string)): Future[string] {.async.} = 
  ## `access_token` : string — (Required) OAuth2 token for which to return details
  var params: seq[Param]
  if `access_token`.isSome(): 
    params.add(newParam("access_token", $access_token))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTokenDetails/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGlobalAchievementPercentagesForAppV1`*(interfacename: AsyncISteamUserStats, `gameid`=none(uint64)): Future[string] {.async.} = 
  ## `gameid` : uint64 — (Required) GameID to retrieve the achievement percentages for
  var params: seq[Param]
  if `gameid`.isSome(): 
    params.add(newParam("gameid", $gameid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGlobalAchievementPercentagesForApp/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGlobalAchievementPercentagesForAppV2`*(interfacename: AsyncISteamUserStats, `gameid`=none(uint64)): Future[string] {.async.} = 
  ## `gameid` : uint64 — (Required) GameID to retrieve the achievement percentages for
  var params: seq[Param]
  if `gameid`.isSome(): 
    params.add(newParam("gameid", $gameid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGlobalAchievementPercentagesForApp/v2/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGlobalStatsForGameV1`*(interfacename: AsyncISteamUserStats, `appid`=none(uint32), `count`=none(uint32), `name`=none(seq[string]), `startdate`=none(uint32), `enddate`=none(uint32)): Future[string] {.async.} = 
  ## `appid` : uint32 — (Required) AppID that we're getting global stats for
  ## `count` : uint32 — (Required) Number of stats get data for
  ## `name[0]` : string — (Required) Names of stat to get data for
  ## `startdate` : uint32 — (Optional) Start date for daily totals (unix epoch timestamp)
  ## `enddate` : uint32 — (Optional) End date for daily totals (unix epoch timestamp)
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `count`.isSome(): 
    params.add(newParam("count", $count))
  if `name`.isSome(): 
    ## Params for seq[]
  if `startdate`.isSome(): 
    params.add(newParam("startdate", $startdate))
  if `enddate`.isSome(): 
    params.add(newParam("enddate", $enddate))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGlobalStatsForGame/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetNumberOfCurrentPlayersV1`*(interfacename: AsyncISteamUserStats, `appid`=none(uint32)): Future[string] {.async.} = 
  ## `appid` : uint32 — (Required) AppID that we're getting user count for
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNumberOfCurrentPlayers/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerAchievementsV1`*(interfacename: AsyncISteamUserStats, `key`=none(string), `steamid`=none(uint64), `appid`=none(uint32), `l`=none(string)): Future[string] {.async.} = 
  ## `key` : string — (Required) access key
  ## `steamid` : uint64 — (Required) SteamID of user
  ## `appid` : uint32 — (Required) AppID to get achievements for
  ## `l` : string — (Optional) Language to return strings for
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `l`.isSome(): 
    params.add(newParam("l", $l))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerAchievements/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaForGameV1`*(interfacename: AsyncISteamUserStats, `key`=none(string), `appid`=none(uint32), `l`=none(string)): Future[string] {.async.} = 
  ## `key` : string — (Required) access key
  ## `appid` : uint32 — (Required) appid of game
  ## `l` : string — (Optional) localized langauge to return (english, french, etc.)
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `l`.isSome(): 
    params.add(newParam("l", $l))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaForGame/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaForGameV2`*(interfacename: AsyncISteamUserStats, `key`=none(string), `appid`=none(uint32), `l`=none(string)): Future[string] {.async.} = 
  ## `key` : string — (Required) access key
  ## `appid` : uint32 — (Required) appid of game
  ## `l` : string — (Optional) localized language to return (english, french, etc.)
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `l`.isSome(): 
    params.add(newParam("l", $l))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaForGame/v2/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetUserStatsForGameV1`*(interfacename: AsyncISteamUserStats, `key`=none(string), `steamid`=none(uint64), `appid`=none(uint32)): Future[string] {.async.} = 
  ## `key` : string — (Required) access key
  ## `steamid` : uint64 — (Required) SteamID of user
  ## `appid` : uint32 — (Required) appid of game
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserStatsForGame/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetUserStatsForGameV2`*(interfacename: AsyncISteamUserStats, `key`=none(string), `steamid`=none(uint64), `appid`=none(uint32)): Future[string] {.async.} = 
  ## `key` : string — (Required) access key
  ## `steamid` : uint64 — (Required) SteamID of user
  ## `appid` : uint32 — (Required) appid of game
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserStatsForGame/v2/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerInfoV1`*(interfacename: AsyncISteamWebAPIUtil): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerInfo/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSupportedAPIListV1`*(interfacename: AsyncISteamWebAPIUtil, `key`=none(string)): Future[string] {.async.} = 
  ## `key` : string — (Optional) access key
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSupportedAPIList/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `PollStatusV1`*(interfacename: AsyncISteamWebUserPresenceOAuth, `steamid`=none(string), `umqid`=none(uint64), `message`=none(uint32), `pollid`=none(uint32), `sectimeout`=none(uint32), `secidletime`=none(uint32), `use_accountids`=none(uint32)): Future[string] {.async.} = 
  ## `steamid` : string — (Required) Steam ID of the user
  ## `umqid` : uint64 — (Required) UMQ Session ID
  ## `message` : uint32 — (Required) Message that was last known to the user
  ## `pollid` : uint32 — (Optional) Caller-specific poll id
  ## `sectimeout` : uint32 — (Optional) Long-poll timeout in seconds
  ## `secidletime` : uint32 — (Optional) How many seconds is client considering itself idle, e.g. screen is off
  ## `use_accountids` : uint32 — (Optional) Boolean, 0 (default): return steamid_from in output, 1: return accountid_from
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `umqid`.isSome(): 
    params.add(newParam("umqid", $umqid))
  if `message`.isSome(): 
    params.add(newParam("message", $message))
  if `pollid`.isSome(): 
    params.add(newParam("pollid", $pollid))
  if `sectimeout`.isSome(): 
    params.add(newParam("sectimeout", $sectimeout))
  if `secidletime`.isSome(): 
    params.add(newParam("secidletime", $secidletime))
  if `use_accountids`.isSome(): 
    params.add(newParam("use_accountids", $use_accountids))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/PollStatus/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `GetGoldenWrenchesV1`*(interfacename: AsyncITFItems_440): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGoldenWrenches/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGoldenWrenchesV2`*(interfacename: AsyncITFItems_440): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGoldenWrenches/v2/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetItemIDV1`*(interfacename: AsyncITFPromos_205790, `steamid`=none(uint64), `promoid`=none(uint32)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `promoid` : uint32 — (Required) The promo ID to grant an item for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `promoid`.isSome(): 
    params.add(newParam("promoid", $promoid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemID/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GrantItemV1`*(interfacename: AsyncITFPromos_205790, `steamid`=none(uint64), `promoid`=none(uint32)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `promoid` : uint32 — (Required) The promo ID to grant an item for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `promoid`.isSome(): 
    params.add(newParam("promoid", $promoid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GrantItem/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `GetItemIDV1`*(interfacename: AsyncITFPromos_440, `steamid`=none(uint64), `promoid`=none(uint32)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `promoid` : uint32 — (Required) The promo ID to grant an item for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `promoid`.isSome(): 
    params.add(newParam("promoid", $promoid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemID/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GrantItemV1`*(interfacename: AsyncITFPromos_440, `steamid`=none(uint64), `promoid`=none(uint32)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `promoid` : uint32 — (Required) The promo ID to grant an item for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `promoid`.isSome(): 
    params.add(newParam("promoid", $promoid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GrantItem/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `GetItemIDV1`*(interfacename: AsyncITFPromos_620, `steamid`=none(uint64), `PromoID`=none(uint32)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `PromoID` : uint32 — (Required) The promo ID to grant an item for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `PromoID`.isSome(): 
    params.add(newParam("PromoID", $PromoID))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemID/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GrantItemV1`*(interfacename: AsyncITFPromos_620, `steamid`=none(uint64), `PromoID`=none(uint32)): Future[string] {.async.} = 
  ## `steamid` : uint64 — (Required) The Steam ID to fetch items for
  ## `PromoID` : uint32 — (Required) The promo ID to grant an item for
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `PromoID`.isSome(): 
    params.add(newParam("PromoID", $PromoID))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GrantItem/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `GetWorldStatusV1`*(interfacename: AsyncITFSystem_440): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetWorldStatus/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetAccountListV1`*(interfacename: AsyncIGameServersService, `key`=none(string)): Future[string] {.async.} = 
  ## Gets a list of game server accounts with their logon tokens
  ## `key` : string — (Required) Access key
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAccountList/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `CreateAccountV1`*(interfacename: AsyncIGameServersService, `key`=none(string), `appid`=none(uint32), `memo`=none(string)): Future[string] {.async.} = 
  ## Creates a persistent game server account
  ## `key` : string — (Required) Access key
  ## `appid` : uint32 — (Required) The app to use the account for
  ## `memo` : string — (Required) The memo to set on the new account
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `memo`.isSome(): 
    params.add(newParam("memo", $memo))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/CreateAccount/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `SetMemoV1`*(interfacename: AsyncIGameServersService, `key`=none(string), `steamid`=none(uint64), `memo`=none(string)): Future[string] {.async.} = 
  ## This method changes the memo associated with the game server account. Memos do not affect the account in any way. The memo shows up in the GetAccountList response and serves only as a reminder of what the account is used for.
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The SteamID of the game server to set the memo on
  ## `memo` : string — (Required) The memo to set on the new account
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `memo`.isSome(): 
    params.add(newParam("memo", $memo))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetMemo/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `ResetLoginTokenV1`*(interfacename: AsyncIGameServersService, `key`=none(string), `steamid`=none(uint64)): Future[string] {.async.} = 
  ## Generates a new login token for the specified game server
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The SteamID of the game server to reset the login token of
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/ResetLoginToken/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `DeleteAccountV1`*(interfacename: AsyncIGameServersService, `key`=none(string), `steamid`=none(uint64)): Future[string] {.async.} = 
  ## Deletes a persistent game server account
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The SteamID of the game server account to delete
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/DeleteAccount/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `GetAccountPublicInfoV1`*(interfacename: AsyncIGameServersService, `key`=none(string), `steamid`=none(uint64)): Future[string] {.async.} = 
  ## Gets public information about a given game server account
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The SteamID of the game server to get info on
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAccountPublicInfo/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `QueryLoginTokenV1`*(interfacename: AsyncIGameServersService, `key`=none(string), `login_token`=none(string)): Future[string] {.async.} = 
  ## Queries the status of the specified token, which must be owned by you
  ## `key` : string — (Required) Access key
  ## `login_token` : string — (Required) Login token to query
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `login_token`.isSome(): 
    params.add(newParam("login_token", $login_token))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/QueryLoginToken/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerSteamIDsByIPV1`*(interfacename: AsyncIGameServersService, `key`=none(string), `server_ips`=none(string)): Future[string] {.async.} = 
  ## Gets a list of server SteamIDs given a list of IPs
  ## `key` : string — (Required) Access key
  ## `server_ips` : string — (Required) 
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `server_ips`.isSome(): 
    params.add(newParam("server_ips", $server_ips))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerSteamIDsByIP/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerIPsBySteamIDV1`*(interfacename: AsyncIGameServersService, `key`=none(string), `server_steamids`=none(uint64)): Future[string] {.async.} = 
  ## Gets a list of server IP addresses given a list of SteamIDs
  ## `key` : string — (Required) Access key
  ## `server_steamids` : uint64 — (Required) 
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `server_steamids`.isSome(): 
    params.add(newParam("server_steamids", $server_steamids))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerIPsBySteamID/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `QueryByFakeIPV1`*(interfacename: AsyncIGameServersService, `key`=none(string), `fake_ip`=none(uint32), `fake_port`=none(uint32), `app_id`=none(uint32), `query_type`=none(int)): Future[string] {.async.} = 
  ## Perform a query on a specific server by FakeIP
  ## `key` : string — (Required) Access key
  ## `fake_ip` : uint32 — (Required) FakeIP of server to query.
  ## `fake_port` : uint32 — (Required) Fake port of server to query.
  ## `app_id` : uint32 — (Required) AppID to use.  Each AppID has its own FakeIP address.
  ## `query_type` : int — (Required) What type of query?
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `fake_ip`.isSome(): 
    params.add(newParam("fake_ip", $fake_ip))
  if `fake_port`.isSome(): 
    params.add(newParam("fake_port", $fake_port))
  if `app_id`.isSome(): 
    params.add(newParam("app_id", $app_id))
  if `query_type`.isSome(): 
    params.add(newParam("query_type", $query_type))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/QueryByFakeIP/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `IsPlayingSharedGameV1`*(interfacename: AsyncIPlayerService, `key`=none(string), `steamid`=none(uint64), `appid_playing`=none(uint32)): Future[string] {.async.} = 
  ## Obsolete, partners should use ISteamUser.CheckAppOwnership
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The player we're asking about
  ## `appid_playing` : uint32 — (Required) The game player is currently playing
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `appid_playing`.isSome(): 
    params.add(newParam("appid_playing", $appid_playing))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/IsPlayingSharedGame/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `RecordOfflinePlaytimeV1`*(interfacename: AsyncIPlayerService, `steamid`=none(uint64), `ticket`=none(string), `play_sessions`=none(Message)): Future[string] {.async.} = 
  ## Tracks playtime for a user when they are offline
  ## `steamid` : uint64 — (Required) 
  ## `ticket` : string — (Required) 
  ## `play_sessions` : Message — (Required) 
  var params: seq[Param]
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `ticket`.isSome(): 
    params.add(newParam("ticket", $ticket))
  if `play_sessions`.isSome(): 
    params.add(newParam("play_sessions", $play_sessions))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/RecordOfflinePlaytime/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `GetRecentlyPlayedGamesV1`*(interfacename: AsyncIPlayerService, `key`=none(string), `steamid`=none(uint64), `count`=none(uint32)): Future[string] {.async.} = 
  ## Gets information about a player's recently played games
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The player we're asking about
  ## `count` : uint32 — (Required) The number of games to return (0/unset: all)
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `count`.isSome(): 
    params.add(newParam("count", $count))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRecentlyPlayedGames/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetOwnedGamesV1`*(interfacename: AsyncIPlayerService, `key`=none(string), `steamid`=none(uint64), `include_appinfo`=none(bool), `include_played_free_games`=none(bool), `appids_filter`=none(uint32), `include_free_sub`=none(bool), `skip_unvetted_apps`=none(bool)): Future[string] {.async.} = 
  ## Return a list of games owned by the player
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The player we're asking about
  ## `include_appinfo` : bool — (Required) true if we want additional details (name, icon) about each game
  ## `include_played_free_games` : bool — (Required) Free games are excluded by default.  If this is set, free games the user has played will be returned.
  ## `appids_filter` : uint32 — (Required) if set, restricts result set to the passed in apps
  ## `include_free_sub` : bool — (Required) Some games are in the free sub, which are excluded by default.
  ## `skip_unvetted_apps` : bool — (Optional) if set, skip unvetted store apps
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `include_appinfo`.isSome(): 
    params.add(newParam("include_appinfo", $include_appinfo))
  if `include_played_free_games`.isSome(): 
    params.add(newParam("include_played_free_games", $include_played_free_games))
  if `appids_filter`.isSome(): 
    params.add(newParam("appids_filter", $appids_filter))
  if `include_free_sub`.isSome(): 
    params.add(newParam("include_free_sub", $include_free_sub))
  if `skip_unvetted_apps`.isSome(): 
    params.add(newParam("skip_unvetted_apps", $skip_unvetted_apps))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetOwnedGames/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSteamLevelV1`*(interfacename: AsyncIPlayerService, `key`=none(string), `steamid`=none(uint64)): Future[string] {.async.} = 
  ## Returns the Steam Level of a user
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The player we're asking about
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamLevel/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetBadgesV1`*(interfacename: AsyncIPlayerService, `key`=none(string), `steamid`=none(uint64)): Future[string] {.async.} = 
  ## Gets badges that are owned by a specific user
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The player we're asking about
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBadges/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetCommunityBadgeProgressV1`*(interfacename: AsyncIPlayerService, `key`=none(string), `steamid`=none(uint64), `badgeid`=none(int32)): Future[string] {.async.} = 
  ## Gets all the quests needed to get the specified badge, and which are completed
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) The player we're asking about
  ## `badgeid` : int32 — (Required) The badge we're asking about
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `badgeid`.isSome(): 
    params.add(newParam("badgeid", $badgeid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCommunityBadgeProgress/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `PostGameDataFrameRTMPV1`*(interfacename: AsyncIBroadcastService, `appid`=none(uint32), `steamid`=none(uint64), `rtmp_token`=none(string), `frame_data`=none(string)): Future[string] {.async.} = 
  ## Add a game meta data frame to broadcast from a client. Uses RTMP token for validation
  ## `appid` : uint32 — (Required) AppID of the game being broadcasted
  ## `steamid` : uint64 — (Required) Broadcasters SteamID
  ## `rtmp_token` : string — (Required) Valid RTMP token for the Broadcaster
  ## `frame_data` : string — (Required) game data frame expressing current state of game (string, zipped, whatever)
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `rtmp_token`.isSome(): 
    params.add(newParam("rtmp_token", $rtmp_token))
  if `frame_data`.isSome(): 
    params.add(newParam("frame_data", $frame_data))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/PostGameDataFrameRTMP/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `SetSteamCacheClientFiltersV1`*(interfacename: AsyncIContentServerConfigService, `key`=none(string), `cache_id`=none(uint32), `cache_key`=none(string), `change_notes`=none(string), `allowed_ip_blocks`=none(string)): Future[string] {.async.} = 
  ## Update the client filters for a SteamCache node
  ## `key` : string — (Required) Access key
  ## `cache_id` : uint32 — (Required) Unique ID number
  ## `cache_key` : string — (Required) Valid current cache API key
  ## `change_notes` : string — (Required) Notes
  ## `allowed_ip_blocks` : string — (Required) comma-separated list of allowed IP address blocks in CIDR format - blank to clear unfilter
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `cache_id`.isSome(): 
    params.add(newParam("cache_id", $cache_id))
  if `cache_key`.isSome(): 
    params.add(newParam("cache_key", $cache_key))
  if `change_notes`.isSome(): 
    params.add(newParam("change_notes", $change_notes))
  if `allowed_ip_blocks`.isSome(): 
    params.add(newParam("allowed_ip_blocks", $allowed_ip_blocks))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamCacheClientFilters/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `GetSteamCacheNodeParamsV1`*(interfacename: AsyncIContentServerConfigService, `key`=none(string), `cache_id`=none(uint32), `cache_key`=none(string)): Future[string] {.async.} = 
  ## Get the operational parameters for a SteamCache node (information the node uses to operate).
  ## `key` : string — (Required) Access key
  ## `cache_id` : uint32 — (Required) Unique ID number
  ## `cache_key` : string — (Required) Valid current cache API key
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `cache_id`.isSome(): 
    params.add(newParam("cache_id", $cache_id))
  if `cache_key`.isSome(): 
    params.add(newParam("cache_key", $cache_key))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamCacheNodeParams/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `SetSteamCachePerformanceStatsV1`*(interfacename: AsyncIContentServerConfigService, `key`=none(string), `cache_id`=none(uint32), `cache_key`=none(string), `mbps_sent`=none(uint32), `mbps_recv`=none(uint32), `cpu_percent`=none(uint32), `cache_hit_percent`=none(uint32), `num_connected_ips`=none(uint32), `upstream_egress_utilization`=none(uint32)): Future[string] {.async.} = 
  ## Update the performance/load stats for a SteamCache node
  ## `key` : string — (Required) Access key
  ## `cache_id` : uint32 — (Required) Unique ID number
  ## `cache_key` : string — (Required) Valid current cache API key
  ## `mbps_sent` : uint32 — (Required) Outgoing network traffic in Mbps
  ## `mbps_recv` : uint32 — (Required) Incoming network traffic in Mbps
  ## `cpu_percent` : uint32 — (Required) Percent CPU load
  ## `cache_hit_percent` : uint32 — (Required) Percent cache hits
  ## `num_connected_ips` : uint32 — (Required) Number of unique connected IP addresses
  ## `upstream_egress_utilization` : uint32 — (Required) What is the percent utilization of the busiest datacenter egress link?
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `cache_id`.isSome(): 
    params.add(newParam("cache_id", $cache_id))
  if `cache_key`.isSome(): 
    params.add(newParam("cache_key", $cache_key))
  if `mbps_sent`.isSome(): 
    params.add(newParam("mbps_sent", $mbps_sent))
  if `mbps_recv`.isSome(): 
    params.add(newParam("mbps_recv", $mbps_recv))
  if `cpu_percent`.isSome(): 
    params.add(newParam("cpu_percent", $cpu_percent))
  if `cache_hit_percent`.isSome(): 
    params.add(newParam("cache_hit_percent", $cache_hit_percent))
  if `num_connected_ips`.isSome(): 
    params.add(newParam("num_connected_ips", $num_connected_ips))
  if `upstream_egress_utilization`.isSome(): 
    params.add(newParam("upstream_egress_utilization", $upstream_egress_utilization))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamCachePerformanceStats/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `GetServersForSteamPipeV1`*(interfacename: AsyncIContentServerDirectoryService, `cell_id`=none(uint32), `max_servers`=none(uint32), `ip_override`=none(string), `launcher_type`=none(int32), `ipv6_public`=none(string)): Future[string] {.async.} = 
  ## `cell_id` : uint32 — (Required) client Cell ID
  ## `max_servers` : uint32 — (Optional) max servers in response list
  ## `ip_override` : string — (Optional) client IP address
  ## `launcher_type` : int32 — (Optional) launcher type
  ## `ipv6_public` : string — (Optional) client public ipv6 address if it knows it
  var params: seq[Param]
  if `cell_id`.isSome(): 
    params.add(newParam("cell_id", $cell_id))
  if `max_servers`.isSome(): 
    params.add(newParam("max_servers", $max_servers))
  if `ip_override`.isSome(): 
    params.add(newParam("ip_override", $ip_override))
  if `launcher_type`.isSome(): 
    params.add(newParam("launcher_type", $launcher_type))
  if `ipv6_public`.isSome(): 
    params.add(newParam("ipv6_public", $ipv6_public))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServersForSteamPipe/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetClientUpdateHostsV1`*(interfacename: AsyncIContentServerDirectoryService, `cached_signature`=none(string)): Future[string] {.async.} = 
  ## `cached_signature` : string — (Required) 
  var params: seq[Param]
  if `cached_signature`.isSome(): 
    params.add(newParam("cached_signature", $cached_signature))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientUpdateHosts/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetDepotPatchInfoV1`*(interfacename: AsyncIContentServerDirectoryService, `appid`=none(uint32), `depotid`=none(uint32), `source_manifestid`=none(uint64), `target_manifestid`=none(uint64)): Future[string] {.async.} = 
  ## `appid` : uint32 — (Required) 
  ## `depotid` : uint32 — (Required) 
  ## `source_manifestid` : uint64 — (Required) 
  ## `target_manifestid` : uint64 — (Required) 
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `depotid`.isSome(): 
    params.add(newParam("depotid", $depotid))
  if `source_manifestid`.isSome(): 
    params.add(newParam("source_manifestid", $source_manifestid))
  if `target_manifestid`.isSome(): 
    params.add(newParam("target_manifestid", $target_manifestid))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetDepotPatchInfo/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetUserVoteSummaryV1`*(interfacename: AsyncIPublishedFileService, `publishedfileids`=none(uint64)): Future[string] {.async.} = 
  ## Get user vote summary
  ## `publishedfileids` : uint64 — (Required) 
  var params: seq[Param]
  if `publishedfileids`.isSome(): 
    params.add(newParam("publishedfileids", $publishedfileids))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserVoteSummary/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `QueryFilesV1`*(interfacename: AsyncIPublishedFileService, `key`=none(string), `query_type`=none(uint32), `page`=none(uint32), `cursor`=none(string), `numperpage`=none(uint32), `creator_appid`=none(uint32), `appid`=none(uint32), `requiredtags`=none(string), `excludedtags`=none(string), `match_all_tags`=none(bool), `required_flags`=none(string), `omitted_flags`=none(string), `search_text`=none(string), `filetype`=none(uint32), `child_publishedfileid`=none(uint64), `days`=none(uint32), `include_recent_votes_only`=none(bool), `cache_max_age_seconds`=none(uint32), `language`=none(int32), `required_kv_tags`=none(Message), `taggroups`=none(Message), `date_range_created`=none(Message), `date_range_updated`=none(Message), `totalonly`=none(bool), `ids_only`=none(bool), `return_vote_data`=none(bool), `return_tags`=none(bool), `return_kv_tags`=none(bool), `return_previews`=none(bool), `return_children`=none(bool), `return_short_description`=none(bool), `return_for_sale_data`=none(bool), `return_metadata`=none(bool), `return_playtime_stats`=none(uint32), `return_details`=none(bool), `strip_description_bbcode`=none(bool), `desired_revision`=none(int), `return_reactions`=none(bool)): Future[string] {.async.} = 
  ## Performs a search query for published files
  ## `key` : string — (Required) Access key
  ## `query_type` : uint32 — (Required) enumeration EPublishedFileQueryType in clientenums.h
  ## `page` : uint32 — (Required) Current page
  ## `cursor` : string — (Required) Cursor to paginate through the results (set to '*' for the first request).  Prefer this over using the page parameter, as it will allow you to do deep pagination.  When used, the page parameter will be ignored.
  ## `numperpage` : uint32 — (Optional) (Optional) The number of results, per page to return.
  ## `creator_appid` : uint32 — (Required) App that created the files
  ## `appid` : uint32 — (Required) App that consumes the files
  ## `requiredtags` : string — (Required) Tags to match on. See match_all_tags parameter below
  ## `excludedtags` : string — (Required) (Optional) Tags that must NOT be present on a published file to satisfy the query.
  ## `match_all_tags` : bool — (Optional) If true, then items must have all the tags specified, otherwise they must have at least one of the tags.
  ## `required_flags` : string — (Required) Required flags that must be set on any returned items
  ## `omitted_flags` : string — (Required) Flags that must not be set on any returned items
  ## `search_text` : string — (Required) Text to match in the item's title or description
  ## `filetype` : uint32 — (Required) EPublishedFileInfoMatchingFileType
  ## `child_publishedfileid` : uint64 — (Required) Find all items that reference the given item.
  ## `days` : uint32 — (Required) If query_type is k_PublishedFileQueryType_RankedByTrend, then this is the number of days to get votes for [1,7].
  ## `include_recent_votes_only` : bool — (Required) If query_type is k_PublishedFileQueryType_RankedByTrend, then limit result set just to items that have votes within the day range given
  ## `cache_max_age_seconds` : uint32 — (Optional) Allow stale data to be returned for the specified number of seconds.
  ## `language` : int32 — (Optional) Language to search in and also what gets returned. Defaults to English.
  ## `required_kv_tags` : Message — (Required) Required key-value tags to match on.
  ## `taggroups` : Message — (Required) (Optional) At least one of the tags must be present on a published file to satisfy the query.
  ## `date_range_created` : Message — (Required) (Optional) Filter to items created within this range.
  ## `date_range_updated` : Message — (Required) (Optional) Filter to items updated within this range.
  ## `totalonly` : bool — (Required) (Optional) If true, only return the total number of files that satisfy this query.
  ## `ids_only` : bool — (Required) (Optional) If true, only return the published file ids of files that satisfy this query.
  ## `return_vote_data` : bool — (Required) Return vote data
  ## `return_tags` : bool — (Required) Return tags in the file details
  ## `return_kv_tags` : bool — (Required) Return key-value tags in the file details
  ## `return_previews` : bool — (Required) Return preview image and video details in the file details
  ## `return_children` : bool — (Required) Return child item ids in the file details
  ## `return_short_description` : bool — (Required) Populate the short_description field instead of file_description
  ## `return_for_sale_data` : bool — (Required) Return pricing information, if applicable
  ## `return_metadata` : bool — (Optional) Populate the metadata
  ## `return_playtime_stats` : uint32 — (Required) Return playtime stats for the specified number of days before today.
  ## `return_details` : bool — (Required) By default, if none of the other 'return_*' fields are set, only some voting details are returned. Set this to true to return the default set of details.
  ## `strip_description_bbcode` : bool — (Required) Strips BBCode from descriptions.
  ## `desired_revision` : int — (Optional) Return the data for the specified revision.
  ## `return_reactions` : bool — (Optional) If true, then reactions to items will be returned.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `query_type`.isSome(): 
    params.add(newParam("query_type", $query_type))
  if `page`.isSome(): 
    params.add(newParam("page", $page))
  if `cursor`.isSome(): 
    params.add(newParam("cursor", $cursor))
  if `numperpage`.isSome(): 
    params.add(newParam("numperpage", $numperpage))
  if `creator_appid`.isSome(): 
    params.add(newParam("creator_appid", $creator_appid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `requiredtags`.isSome(): 
    params.add(newParam("requiredtags", $requiredtags))
  if `excludedtags`.isSome(): 
    params.add(newParam("excludedtags", $excludedtags))
  if `match_all_tags`.isSome(): 
    params.add(newParam("match_all_tags", $match_all_tags))
  if `required_flags`.isSome(): 
    params.add(newParam("required_flags", $required_flags))
  if `omitted_flags`.isSome(): 
    params.add(newParam("omitted_flags", $omitted_flags))
  if `search_text`.isSome(): 
    params.add(newParam("search_text", $search_text))
  if `filetype`.isSome(): 
    params.add(newParam("filetype", $filetype))
  if `child_publishedfileid`.isSome(): 
    params.add(newParam("child_publishedfileid", $child_publishedfileid))
  if `days`.isSome(): 
    params.add(newParam("days", $days))
  if `include_recent_votes_only`.isSome(): 
    params.add(newParam("include_recent_votes_only", $include_recent_votes_only))
  if `cache_max_age_seconds`.isSome(): 
    params.add(newParam("cache_max_age_seconds", $cache_max_age_seconds))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `required_kv_tags`.isSome(): 
    params.add(newParam("required_kv_tags", $required_kv_tags))
  if `taggroups`.isSome(): 
    params.add(newParam("taggroups", $taggroups))
  if `date_range_created`.isSome(): 
    params.add(newParam("date_range_created", $date_range_created))
  if `date_range_updated`.isSome(): 
    params.add(newParam("date_range_updated", $date_range_updated))
  if `totalonly`.isSome(): 
    params.add(newParam("totalonly", $totalonly))
  if `ids_only`.isSome(): 
    params.add(newParam("ids_only", $ids_only))
  if `return_vote_data`.isSome(): 
    params.add(newParam("return_vote_data", $return_vote_data))
  if `return_tags`.isSome(): 
    params.add(newParam("return_tags", $return_tags))
  if `return_kv_tags`.isSome(): 
    params.add(newParam("return_kv_tags", $return_kv_tags))
  if `return_previews`.isSome(): 
    params.add(newParam("return_previews", $return_previews))
  if `return_children`.isSome(): 
    params.add(newParam("return_children", $return_children))
  if `return_short_description`.isSome(): 
    params.add(newParam("return_short_description", $return_short_description))
  if `return_for_sale_data`.isSome(): 
    params.add(newParam("return_for_sale_data", $return_for_sale_data))
  if `return_metadata`.isSome(): 
    params.add(newParam("return_metadata", $return_metadata))
  if `return_playtime_stats`.isSome(): 
    params.add(newParam("return_playtime_stats", $return_playtime_stats))
  if `return_details`.isSome(): 
    params.add(newParam("return_details", $return_details))
  if `strip_description_bbcode`.isSome(): 
    params.add(newParam("strip_description_bbcode", $strip_description_bbcode))
  if `desired_revision`.isSome(): 
    params.add(newParam("desired_revision", $desired_revision))
  if `return_reactions`.isSome(): 
    params.add(newParam("return_reactions", $return_reactions))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/QueryFiles/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetDetailsV1`*(interfacename: AsyncIPublishedFileService, `key`=none(string), `publishedfileids`=none(uint64), `includetags`=none(bool), `includeadditionalpreviews`=none(bool), `includechildren`=none(bool), `includekvtags`=none(bool), `includevotes`=none(bool), `short_description`=none(bool), `includeforsaledata`=none(bool), `includemetadata`=none(bool), `language`=none(int32), `return_playtime_stats`=none(uint32), `appid`=none(uint32), `strip_description_bbcode`=none(bool), `desired_revision`=none(int), `includereactions`=none(bool)): Future[string] {.async.} = 
  ## Retrieves information about a set of published files.
  ## `key` : string — (Required) Access key
  ## `publishedfileids` : uint64 — (Required) Set of published file Ids to retrieve details for.
  ## `includetags` : bool — (Required) If true, return tag information in the returned details.
  ## `includeadditionalpreviews` : bool — (Required) If true, return preview information in the returned details.
  ## `includechildren` : bool — (Required) If true, return children in the returned details.
  ## `includekvtags` : bool — (Required) If true, return key value tags in the returned details.
  ## `includevotes` : bool — (Required) If true, return vote data in the returned details.
  ## `short_description` : bool — (Required) If true, return a short description instead of the full description.
  ## `includeforsaledata` : bool — (Required) If true, return pricing data, if applicable.
  ## `includemetadata` : bool — (Required) If true, populate the metadata field.
  ## `language` : int32 — (Optional) Specifies the localized text to return. Defaults to English.
  ## `return_playtime_stats` : uint32 — (Required) Return playtime stats for the specified number of days before today.
  ## `appid` : uint32 — (Required) 
  ## `strip_description_bbcode` : bool — (Required) Strips BBCode from descriptions.
  ## `desired_revision` : int — (Optional) Return the data for the specified revision.
  ## `includereactions` : bool — (Optional) If true, then reactions to items will be returned.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `publishedfileids`.isSome(): 
    params.add(newParam("publishedfileids", $publishedfileids))
  if `includetags`.isSome(): 
    params.add(newParam("includetags", $includetags))
  if `includeadditionalpreviews`.isSome(): 
    params.add(newParam("includeadditionalpreviews", $includeadditionalpreviews))
  if `includechildren`.isSome(): 
    params.add(newParam("includechildren", $includechildren))
  if `includekvtags`.isSome(): 
    params.add(newParam("includekvtags", $includekvtags))
  if `includevotes`.isSome(): 
    params.add(newParam("includevotes", $includevotes))
  if `short_description`.isSome(): 
    params.add(newParam("short_description", $short_description))
  if `includeforsaledata`.isSome(): 
    params.add(newParam("includeforsaledata", $includeforsaledata))
  if `includemetadata`.isSome(): 
    params.add(newParam("includemetadata", $includemetadata))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `return_playtime_stats`.isSome(): 
    params.add(newParam("return_playtime_stats", $return_playtime_stats))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `strip_description_bbcode`.isSome(): 
    params.add(newParam("strip_description_bbcode", $strip_description_bbcode))
  if `desired_revision`.isSome(): 
    params.add(newParam("desired_revision", $desired_revision))
  if `includereactions`.isSome(): 
    params.add(newParam("includereactions", $includereactions))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetDetails/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetUserFilesV1`*(interfacename: AsyncIPublishedFileService, `key`=none(string), `steamid`=none(uint64), `appid`=none(uint32), `page`=none(uint32), `numperpage`=none(uint32), `type`=none(string), `sortmethod`=none(string), `privacy`=none(uint32), `requiredtags`=none(string), `excludedtags`=none(string), `required_kv_tags`=none(Message), `filetype`=none(uint32), `creator_appid`=none(uint32), `match_cloud_filename`=none(string), `cache_max_age_seconds`=none(uint32), `language`=none(int32), `taggroups`=none(Message), `totalonly`=none(bool), `ids_only`=none(bool), `return_vote_data`=none(bool), `return_tags`=none(bool), `return_kv_tags`=none(bool), `return_previews`=none(bool), `return_children`=none(bool), `return_short_description`=none(bool), `return_for_sale_data`=none(bool), `return_metadata`=none(bool), `return_playtime_stats`=none(uint32), `strip_description_bbcode`=none(bool), `return_reactions`=none(bool), `startindex_override`=none(uint32), `desired_revision`=none(int)): Future[string] {.async.} = 
  ## Retrieves files published by a user.
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) Steam ID of the user whose files are being requested.
  ## `appid` : uint32 — (Required) App Id of the app that the files were published to.
  ## `page` : uint32 — (Optional) (Optional) Starting page for results.
  ## `numperpage` : uint32 — (Optional) (Optional) The number of results, per page to return.
  ## `type` : string — (Optional) (Optional) Type of files to be returned.
  ## `sortmethod` : string — (Optional) (Optional) Sorting method to use on returned values.
  ## `privacy` : uint32 — (Required) (optional) Filter by privacy settings.
  ## `requiredtags` : string — (Required) (Optional) Tags that must be present on a published file to satisfy the query.
  ## `excludedtags` : string — (Required) (Optional) Tags that must NOT be present on a published file to satisfy the query.
  ## `required_kv_tags` : Message — (Required) Required key-value tags to match on.
  ## `filetype` : uint32 — (Required) (Optional) File type to match files to.
  ## `creator_appid` : uint32 — (Required) App Id of the app that published the files, only matched if specified.
  ## `match_cloud_filename` : string — (Required) Match this cloud filename if specified.
  ## `cache_max_age_seconds` : uint32 — (Optional) Allow stale data to be returned for the specified number of seconds.
  ## `language` : int32 — (Optional) Specifies the localized text to return. Defaults to English.
  ## `taggroups` : Message — (Required) (Optional) At least one of the tags must be present on a published file to satisfy the query.
  ## `totalonly` : bool — (Required) (Optional) If true, only return the total number of files that satisfy this query.
  ## `ids_only` : bool — (Required) (Optional) If true, only return the published file ids of files that satisfy this query.
  ## `return_vote_data` : bool — (Optional) Return vote data
  ## `return_tags` : bool — (Required) Return tags in the file details
  ## `return_kv_tags` : bool — (Optional) Return key-value tags in the file details
  ## `return_previews` : bool — (Required) Return preview image and video details in the file details
  ## `return_children` : bool — (Required) Return child item ids in the file details
  ## `return_short_description` : bool — (Optional) Populate the short_description field instead of file_description
  ## `return_for_sale_data` : bool — (Required) Return pricing information, if applicable
  ## `return_metadata` : bool — (Optional) Populate the metadata field
  ## `return_playtime_stats` : uint32 — (Required) Return playtime stats for the specified number of days before today.
  ## `strip_description_bbcode` : bool — (Required) Strips BBCode from descriptions.
  ## `return_reactions` : bool — (Optional) If true, then reactions to items will be returned.
  ## `startindex_override` : uint32 — (Required) Backwards compatible for the client.
  ## `desired_revision` : int — (Optional) Return the data for the specified revision.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `page`.isSome(): 
    params.add(newParam("page", $page))
  if `numperpage`.isSome(): 
    params.add(newParam("numperpage", $numperpage))
  if `type`.isSome(): 
    params.add(newParam("type", $type))
  if `sortmethod`.isSome(): 
    params.add(newParam("sortmethod", $sortmethod))
  if `privacy`.isSome(): 
    params.add(newParam("privacy", $privacy))
  if `requiredtags`.isSome(): 
    params.add(newParam("requiredtags", $requiredtags))
  if `excludedtags`.isSome(): 
    params.add(newParam("excludedtags", $excludedtags))
  if `required_kv_tags`.isSome(): 
    params.add(newParam("required_kv_tags", $required_kv_tags))
  if `filetype`.isSome(): 
    params.add(newParam("filetype", $filetype))
  if `creator_appid`.isSome(): 
    params.add(newParam("creator_appid", $creator_appid))
  if `match_cloud_filename`.isSome(): 
    params.add(newParam("match_cloud_filename", $match_cloud_filename))
  if `cache_max_age_seconds`.isSome(): 
    params.add(newParam("cache_max_age_seconds", $cache_max_age_seconds))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `taggroups`.isSome(): 
    params.add(newParam("taggroups", $taggroups))
  if `totalonly`.isSome(): 
    params.add(newParam("totalonly", $totalonly))
  if `ids_only`.isSome(): 
    params.add(newParam("ids_only", $ids_only))
  if `return_vote_data`.isSome(): 
    params.add(newParam("return_vote_data", $return_vote_data))
  if `return_tags`.isSome(): 
    params.add(newParam("return_tags", $return_tags))
  if `return_kv_tags`.isSome(): 
    params.add(newParam("return_kv_tags", $return_kv_tags))
  if `return_previews`.isSome(): 
    params.add(newParam("return_previews", $return_previews))
  if `return_children`.isSome(): 
    params.add(newParam("return_children", $return_children))
  if `return_short_description`.isSome(): 
    params.add(newParam("return_short_description", $return_short_description))
  if `return_for_sale_data`.isSome(): 
    params.add(newParam("return_for_sale_data", $return_for_sale_data))
  if `return_metadata`.isSome(): 
    params.add(newParam("return_metadata", $return_metadata))
  if `return_playtime_stats`.isSome(): 
    params.add(newParam("return_playtime_stats", $return_playtime_stats))
  if `strip_description_bbcode`.isSome(): 
    params.add(newParam("strip_description_bbcode", $strip_description_bbcode))
  if `return_reactions`.isSome(): 
    params.add(newParam("return_reactions", $return_reactions))
  if `startindex_override`.isSome(): 
    params.add(newParam("startindex_override", $startindex_override))
  if `desired_revision`.isSome(): 
    params.add(newParam("desired_revision", $desired_revision))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserFiles/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTradeHistoryV1`*(interfacename: AsyncIEconService, `key`=none(string), `max_trades`=none(uint32), `start_after_time`=none(uint32), `start_after_tradeid`=none(uint64), `navigating_back`=none(bool), `get_descriptions`=none(bool), `language`=none(string), `include_failed`=none(bool), `include_total`=none(bool)): Future[string] {.async.} = 
  ## Gets a history of trades
  ## `key` : string — (Required) Access key
  ## `max_trades` : uint32 — (Required) The number of trades to return information for
  ## `start_after_time` : uint32 — (Required) The time of the last trade shown on the previous page of results, or the time of the first trade if navigating back
  ## `start_after_tradeid` : uint64 — (Required) The tradeid shown on the previous page of results, or the ID of the first trade if navigating back
  ## `navigating_back` : bool — (Required) The user wants the previous page of results, so return the previous max_trades trades before the start time and ID
  ## `get_descriptions` : bool — (Required) If set, the item display data for the items included in the returned trades will also be returned
  ## `language` : string — (Required) The language to use when loading item display data
  ## `include_failed` : bool — (Required) 
  ## `include_total` : bool — (Required) If set, the total number of trades the account has participated in will be included in the response
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `max_trades`.isSome(): 
    params.add(newParam("max_trades", $max_trades))
  if `start_after_time`.isSome(): 
    params.add(newParam("start_after_time", $start_after_time))
  if `start_after_tradeid`.isSome(): 
    params.add(newParam("start_after_tradeid", $start_after_tradeid))
  if `navigating_back`.isSome(): 
    params.add(newParam("navigating_back", $navigating_back))
  if `get_descriptions`.isSome(): 
    params.add(newParam("get_descriptions", $get_descriptions))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `include_failed`.isSome(): 
    params.add(newParam("include_failed", $include_failed))
  if `include_total`.isSome(): 
    params.add(newParam("include_total", $include_total))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeHistory/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTradeStatusV1`*(interfacename: AsyncIEconService, `key`=none(string), `tradeid`=none(uint64), `get_descriptions`=none(bool), `language`=none(string)): Future[string] {.async.} = 
  ## Gets status for a specific trade
  ## `key` : string — (Required) Access key
  ## `tradeid` : uint64 — (Required) 
  ## `get_descriptions` : bool — (Required) If set, the item display data for the items included in the returned trades will also be returned
  ## `language` : string — (Required) The language to use when loading item display data
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `tradeid`.isSome(): 
    params.add(newParam("tradeid", $tradeid))
  if `get_descriptions`.isSome(): 
    params.add(newParam("get_descriptions", $get_descriptions))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeStatus/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTradeOffersV1`*(interfacename: AsyncIEconService, `key`=none(string), `get_sent_offers`=none(bool), `get_received_offers`=none(bool), `get_descriptions`=none(bool), `language`=none(string), `active_only`=none(bool), `historical_only`=none(bool), `time_historical_cutoff`=none(uint32), `cursor`=none(uint32)): Future[string] {.async.} = 
  ## Get a list of sent or received trade offers
  ## `key` : string — (Required) Access key
  ## `get_sent_offers` : bool — (Required) Request the list of sent offers.
  ## `get_received_offers` : bool — (Required) Request the list of received offers.
  ## `get_descriptions` : bool — (Required) If set, the item display data for the items included in the returned trade offers will also be returned. If one or more descriptions can't be retrieved, then your request will fail.
  ## `language` : string — (Required) The language to use when loading item display data.
  ## `active_only` : bool — (Required) Indicates we should only return offers which are still active, or offers that have changed in state since the time_historical_cutoff
  ## `historical_only` : bool — (Required) Indicates we should only return offers which are not active.
  ## `time_historical_cutoff` : uint32 — (Required) When active_only is set, offers updated since this time will also be returned
  ## `cursor` : uint32 — (Optional) Cursor aka start index
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `get_sent_offers`.isSome(): 
    params.add(newParam("get_sent_offers", $get_sent_offers))
  if `get_received_offers`.isSome(): 
    params.add(newParam("get_received_offers", $get_received_offers))
  if `get_descriptions`.isSome(): 
    params.add(newParam("get_descriptions", $get_descriptions))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `active_only`.isSome(): 
    params.add(newParam("active_only", $active_only))
  if `historical_only`.isSome(): 
    params.add(newParam("historical_only", $historical_only))
  if `time_historical_cutoff`.isSome(): 
    params.add(newParam("time_historical_cutoff", $time_historical_cutoff))
  if `cursor`.isSome(): 
    params.add(newParam("cursor", $cursor))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeOffers/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTradeOfferV1`*(interfacename: AsyncIEconService, `key`=none(string), `tradeofferid`=none(uint64), `language`=none(string), `get_descriptions`=none(bool)): Future[string] {.async.} = 
  ## Gets a specific trade offer
  ## `key` : string — (Required) Access key
  ## `tradeofferid` : uint64 — (Required) 
  ## `language` : string — (Required) 
  ## `get_descriptions` : bool — (Required) If set, the item display data for the items included in the returned trade offers will also be returned. If one or more descriptions can't be retrieved, then your request will fail.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `tradeofferid`.isSome(): 
    params.add(newParam("tradeofferid", $tradeofferid))
  if `language`.isSome(): 
    params.add(newParam("language", $language))
  if `get_descriptions`.isSome(): 
    params.add(newParam("get_descriptions", $get_descriptions))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeOffer/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTradeOffersSummaryV1`*(interfacename: AsyncIEconService, `key`=none(string), `time_last_visit`=none(uint32)): Future[string] {.async.} = 
  ## Get counts of pending and new trade offers
  ## `key` : string — (Required) Access key
  ## `time_last_visit` : uint32 — (Required) The time the user last visited.  If not passed, will use the time the user last visited the trade offer page.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `time_last_visit`.isSome(): 
    params.add(newParam("time_last_visit", $time_last_visit))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeOffersSummary/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTradeHoldDurationsV1`*(interfacename: AsyncIEconService, `key`=none(string), `steamid_target`=none(uint64), `trade_offer_access_token`=none(string)): Future[string] {.async.} = 
  ## Returns the estimated hold duration and end date that a trade with a user would have
  ## `key` : string — (Required) Access key
  ## `steamid_target` : uint64 — (Required) User you are trading with
  ## `trade_offer_access_token` : string — (Required) A special token that allows for trade offers from non-friends.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid_target`.isSome(): 
    params.add(newParam("steamid_target", $steamid_target))
  if `trade_offer_access_token`.isSome(): 
    params.add(newParam("trade_offer_access_token", $trade_offer_access_token))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeHoldDurations/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `UserCreateSessionV1`*(interfacename: AsyncIGameNotificationsService, `appid`=none(uint32), `context`=none(uint64), `title`=none(Message), `users`=none(Message), `steamid`=none(uint64)): Future[string] {.async.} = 
  ## Creates an async game session
  ## `appid` : uint32 — (Required) The appid to create the session for.
  ## `context` : uint64 — (Required) Game-specified context value the game can used to associate the session with some object on their backend.
  ## `title` : Message — (Required) The title of the session to be displayed within each user's list of sessions.
  ## `users` : Message — (Required) The initial state of all users in the session.
  ## `steamid` : uint64 — (Required) (Optional) steamid to make the request on behalf of -- if specified, the user must be in the session and all users being added to the session must be friends with the user.
  var params: seq[Param]
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `context`.isSome(): 
    params.add(newParam("context", $context))
  if `title`.isSome(): 
    params.add(newParam("title", $title))
  if `users`.isSome(): 
    params.add(newParam("users", $users))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UserCreateSession/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `UserUpdateSessionV1`*(interfacename: AsyncIGameNotificationsService, `sessionid`=none(uint64), `appid`=none(uint32), `title`=none(Message), `users`=none(Message), `steamid`=none(uint64)): Future[string] {.async.} = 
  ## Updates an async game session
  ## `sessionid` : uint64 — (Required) The sessionid to update.
  ## `appid` : uint32 — (Required) The appid of the session to update.
  ## `title` : Message — (Required) (Optional) The new title of the session.  If not specified, the title will not be changed.
  ## `users` : Message — (Required) (Optional) A list of users whose state will be updated to reflect the given state. If the users are not already in the session, they will be added to it.
  ## `steamid` : uint64 — (Required) (Optional) steamid to make the request on behalf of -- if specified, the user must be in the session and all users being added to the session must be friends with the user.
  var params: seq[Param]
  if `sessionid`.isSome(): 
    params.add(newParam("sessionid", $sessionid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `title`.isSome(): 
    params.add(newParam("title", $title))
  if `users`.isSome(): 
    params.add(newParam("users", $users))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UserUpdateSession/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `UserDeleteSessionV1`*(interfacename: AsyncIGameNotificationsService, `sessionid`=none(uint64), `appid`=none(uint32), `steamid`=none(uint64)): Future[string] {.async.} = 
  ## Deletes an async game session
  ## `sessionid` : uint64 — (Required) The sessionid to delete.
  ## `appid` : uint32 — (Required) The appid of the session to delete.
  ## `steamid` : uint64 — (Required) (Optional) steamid to make the request on behalf of -- if specified, the user must be in the session.
  var params: seq[Param]
  if `sessionid`.isSome(): 
    params.add(newParam("sessionid", $sessionid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UserDeleteSession/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `SplitItemStackV1`*(interfacename: AsyncIInventoryService, `key`=none(string), `appid`=none(uint32), `itemid`=none(uint64), `quantity`=none(uint32), `steamid`=none(uint64)): Future[string] {.async.} = 
  ## Split an item stack into two stacks
  ## `key` : string — (Required) Access key
  ## `appid` : uint32 — (Required) 
  ## `itemid` : uint64 — (Required) 
  ## `quantity` : uint32 — (Required) 
  ## `steamid` : uint64 — (Required) 
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `itemid`.isSome(): 
    params.add(newParam("itemid", $itemid))
  if `quantity`.isSome(): 
    params.add(newParam("quantity", $quantity))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SplitItemStack/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `CombineItemStacksV1`*(interfacename: AsyncIInventoryService, `key`=none(string), `appid`=none(uint32), `fromitemid`=none(uint64), `destitemid`=none(uint64), `quantity`=none(uint32), `steamid`=none(uint64)): Future[string] {.async.} = 
  ## Combine two stacks of items
  ## `key` : string — (Required) Access key
  ## `appid` : uint32 — (Required) 
  ## `fromitemid` : uint64 — (Required) 
  ## `destitemid` : uint64 — (Required) 
  ## `quantity` : uint32 — (Required) 
  ## `steamid` : uint64 — (Required) 
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `fromitemid`.isSome(): 
    params.add(newParam("fromitemid", $fromitemid))
  if `destitemid`.isSome(): 
    params.add(newParam("destitemid", $destitemid))
  if `quantity`.isSome(): 
    params.add(newParam("quantity", $quantity))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/CombineItemStacks/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 

proc `GetPriceSheetV1`*(interfacename: AsyncIInventoryService, `key`=none(string), `ecurrency`=none(int32), `currency_code`=none(string)): Future[string] {.async.} = 
  ## Get the Inventory Service price sheet
  ## `key` : string — (Required) Access key
  ## `ecurrency` : int32 — (Required) 
  ## `currency_code` : string — (Required) Standard short code of the requested currency (preferred)
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `ecurrency`.isSome(): 
    params.add(newParam("ecurrency", $ecurrency))
  if `currency_code`.isSome(): 
    params.add(newParam("currency_code", $currency_code))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPriceSheet/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetAppListV1`*(interfacename: AsyncIStoreService, `key`=none(string), `if_modified_since`=none(uint32), `have_description_language`=none(string), `include_games`=none(bool), `include_dlc`=none(bool), `include_software`=none(bool), `include_videos`=none(bool), `include_hardware`=none(bool), `last_appid`=none(uint32), `max_results`=none(uint32)): Future[string] {.async.} = 
  ## Gets a list of apps available on the Steam Store.
  ## `key` : string — (Required) Access key
  ## `if_modified_since` : uint32 — (Optional) Return only items that have been modified since this date.
  ## `have_description_language` : string — (Optional) Return only items that have a description in this language.
  ## `include_games` : bool — (Optional) Include games (defaults to enabled)
  ## `include_dlc` : bool — (Optional) Include DLC
  ## `include_software` : bool — (Optional) Include software items
  ## `include_videos` : bool — (Optional) Include videos and series
  ## `include_hardware` : bool — (Optional) Include hardware
  ## `last_appid` : uint32 — (Optional) For continuations, this is the last appid returned from the previous call.
  ## `max_results` : uint32 — (Optional) Number of results to return at a time.  Default 10k, max 50k.
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `if_modified_since`.isSome(): 
    params.add(newParam("if_modified_since", $if_modified_since))
  if `have_description_language`.isSome(): 
    params.add(newParam("have_description_language", $have_description_language))
  if `include_games`.isSome(): 
    params.add(newParam("include_games", $include_games))
  if `include_dlc`.isSome(): 
    params.add(newParam("include_dlc", $include_dlc))
  if `include_software`.isSome(): 
    params.add(newParam("include_software", $include_software))
  if `include_videos`.isSome(): 
    params.add(newParam("include_videos", $include_videos))
  if `include_hardware`.isSome(): 
    params.add(newParam("include_hardware", $include_hardware))
  if `last_appid`.isSome(): 
    params.add(newParam("last_appid", $last_appid))
  if `max_results`.isSome(): 
    params.add(newParam("max_results", $max_results))
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAppList/v1/"&prm2get(params)
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `ReportCheatDataV1`*(interfacename: AsyncICheatReportingService, `key`=none(string), `steamid`=none(uint64), `appid`=none(uint32), `pathandfilename`=none(string), `webcheaturl`=none(string), `time_now`=none(uint64), `time_started`=none(uint64), `time_stopped`=none(uint64), `cheatname`=none(string), `game_process_id`=none(uint32), `cheat_process_id`=none(uint32), `cheat_param_1`=none(uint64), `cheat_param_2`=none(uint64), `cheat_data_dump`=none(string)): Future[string] {.async.} = 
  ## Reports cheat data. Only use on test account that is running the game but not in a multiplayer session.
  ## `key` : string — (Required) Access key
  ## `steamid` : uint64 — (Required) steamid of the user running and reporting the cheat.
  ## `appid` : uint32 — (Required) The appid.
  ## `pathandfilename` : string — (Required) path and file name of the cheat executable.
  ## `webcheaturl` : string — (Required) web url where the cheat was found and downloaded.
  ## `time_now` : uint64 — (Required) local system time now.
  ## `time_started` : uint64 — (Required) local system time when cheat process started. ( 0 if not yet run )
  ## `time_stopped` : uint64 — (Required) local system time when cheat process stopped. ( 0 if still running )
  ## `cheatname` : string — (Required) descriptive name for the cheat.
  ## `game_process_id` : uint32 — (Required) process ID of the running game.
  ## `cheat_process_id` : uint32 — (Required) process ID of the cheat process that ran
  ## `cheat_param_1` : uint64 — (Required) cheat param 1
  ## `cheat_param_2` : uint64 — (Required) cheat param 2
  ## `cheat_data_dump` : string — (Required) data collection in json format
  var params: seq[Param]
  if `key`.isSome(): 
    params.add(newParam("key", $key))
  if `steamid`.isSome(): 
    params.add(newParam("steamid", $steamid))
  if `appid`.isSome(): 
    params.add(newParam("appid", $appid))
  if `pathandfilename`.isSome(): 
    params.add(newParam("pathandfilename", $pathandfilename))
  if `webcheaturl`.isSome(): 
    params.add(newParam("webcheaturl", $webcheaturl))
  if `time_now`.isSome(): 
    params.add(newParam("time_now", $time_now))
  if `time_started`.isSome(): 
    params.add(newParam("time_started", $time_started))
  if `time_stopped`.isSome(): 
    params.add(newParam("time_stopped", $time_stopped))
  if `cheatname`.isSome(): 
    params.add(newParam("cheatname", $cheatname))
  if `game_process_id`.isSome(): 
    params.add(newParam("game_process_id", $game_process_id))
  if `cheat_process_id`.isSome(): 
    params.add(newParam("cheat_process_id", $cheat_process_id))
  if `cheat_param_1`.isSome(): 
    params.add(newParam("cheat_param_1", $cheat_param_1))
  if `cheat_param_2`.isSome(): 
    params.add(newParam("cheat_param_2", $cheat_param_2))
  if `cheat_data_dump`.isSome(): 
    params.add(newParam("cheat_data_dump", $cheat_data_dump))
  let body = prm2post(params)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/ReportCheatData/v1/"
  var client = newAsyncHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded" }) 
  return await client.postContent(url, body = body) 
