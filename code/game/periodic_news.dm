/datum/news_announcement
	var/round_time // time of the round at which this should be announced, in seconds
	var/message // body of the message
	var/author = "Editor"
	var/channel_name = "Copernicus Daily"
	var/can_be_redacted = 0
	var/message_type = "Story"

var/global/list/newscaster_standard_feeds = list()

proc/process_newscaster()
	check_for_newscaster_updates(SSticker.mode.newscaster_announcements)

var/global/tmp/announced_news_types = list()
proc/check_for_newscaster_updates(type)
	if(type)
		for(var/subtype in typesof(type)-type)
			var/datum/news_announcement/news = new subtype()
			if(news.round_time * 10 <= world.time && !(subtype in announced_news_types))
				announced_news_types += subtype
				announce_newscaster_news(news)

proc/announce_newscaster_news(datum/news_announcement/news)
	var/datum/feed_channel/sendto
	for(var/datum/feed_channel/FC in news_network.network_channels)
		if(FC.channel_name == news.channel_name)
			sendto = FC
			break

	if(!sendto)
		sendto = new /datum/feed_channel
		sendto.channel_name = news.channel_name
		sendto.author = news.author
		sendto.locked = 1
		sendto.is_admin_channel = 1
		news_network.network_channels += sendto

	var/author = news.author ? news.author : sendto.author
	news_network.SubmitArticle(news.message, author, news.channel_name, null, !news.can_be_redacted, news.message_type)
