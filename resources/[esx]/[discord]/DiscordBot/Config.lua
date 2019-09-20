DiscordWebhookSystemInfos = ''
DiscordWebhookStart = ''
DiscordWebhookKillinglogs = ''
DiscordWebhookChat = ''
DiscordWebhookCheat = ''

SystemAvatar = 'https://imgur.com/a/zQzOWqn'

UserAvatar = 'https://imgur.com/a/Yd43CUj'

SystemName = 'L\'Oeil d\'Arkadia'


--[[ Special Commands formatting
		 *YOUR_TEXT*			--> Make Text Italics in Discord
		**YOUR_TEXT**			--> Make Text Bold in Discord
	   ***YOUR_TEXT***			--> Make Text Italics & Bold in Discord
		__YOUR_TEXT__			--> Underline Text in Discord
	   __*YOUR_TEXT*__			--> Underline Text and make it Italics in Discord
	  __**YOUR_TEXT**__			--> Underline Text and make it Bold in Discord
	 __***YOUR_TEXT***__		--> Underline Text and make it Italics & Bold in Discord
		~~YOUR_TEXT~~			--> Strikethrough Text in Discord
]]
-- Use 'USERNAME_NEEDED_HERE' without the quotes if you need a Users Name in a special command
-- Use 'USERID_NEEDED_HERE' without the quotes if you need a Users ID in a special command


-- These special commands will be printed differently in discord, depending on what you set it to
SpecialCommands = {
				   {'/ooc', '**[OOC]:**'},
				   -- {'/twt', '**[TWITTER]:**'},
				   {'/news', '**[ANNONCE PUBLICITAIRE]:**'},
				   {'/report', '**[REPORT]:**'},
				   {'/911', '**[911]: (CALLER ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				  }

						
-- These blacklisted commands will not be printed in discord
BlacklistedCommands = {
					   '/AnyCommand',
					   '/AnyCommand2',
					  }

-- These Commands will use their own webhook
OwnWebhookCommands = {
				--	  {'/ano', 'https://discordapp.com/api/webhooks/612930758239322122/NWCrST9iHtrvIvgUJaHlZI1w10xOFr7EeZoxP4xMF4AHo1CsSZbPg6ZStLUaKbQfCRpK'},
					  {'/AnotherCommand2', 'WEBHOOK_LINK_HERE'},
					 }

-- These Commands will be sent as TTS messages
TTSCommands = {
			   '/Whatever',
			   '/Whatever2',
			  }

