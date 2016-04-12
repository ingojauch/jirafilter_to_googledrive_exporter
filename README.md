# jirafilter_to_googledrive_exporter

Simple ruby wrapper for curl and googledrive api gems to download a jira filter as excel file and then upload it to goodle drive in order to share it with whoever you like without giving them access to your JIRA


## Installation

To run the script you need curl and any ruby (and bundler) installed:
```
	$ bundle install
```

1. Go to https://wp-analytify.com/get-client-id-client-secret-developer-api-key-google-developers-console-application and follow the instructions to get a DRIVE_ID (CLIENT_ID) and DRIVE_SECRET (CLIENT_DRIVE_SECRET)
e.g. CLIENT_ID = '784589054626-9p74803sm1lenbh1ani234egf9pg0ktu.apps.googleusercontent.com'
CLIENT_SECRET = 'W79-vzpphE0IxzFefrernygfti'

2. Then run the script with a terminal (manualy) to generate a token (stored_token.json)
e.g. {"refresh_token":"1/4_nUWCFpjFcccavP7I6zUS0beergaergaergPBactUREZofsF9C7PrpE-j"}

3. login to JIRA and create a filter and save it, then to to any JIRA project and to to issues. Then click on your filter, and rearange the columns as you like, then click Export -> Excel (current fields) -> Remember this URL and filename


## Usage

Run ./jirafilter_to_googledrive_exporter.rb DRIVE_ID DRIVE_SECRET JIRA_FILTER_URL JIRA_LOGIN JIRA_PASSWORD JIRA_FILTER_FILE_NAME
