#!/usr/bin/env ruby

require "google/api_client"
require "google_drive"

def helptext
	puts "Usage: ./jirafilter_to_googledrive_exporter.rb DRIVE_ID DRIVE_SECRET JIRA_FILTER_URL JIRA_LOGIN JIRA_PASSWORD JIRA_FILTER_FILE_NAME"
end

# https://wp-analytify.com/get-client-id-client-secret-developer-api-key-google-developers-console-application/
# The client ID and client secret you obtained in the step above.

if ARGV.count != 6
    helptext
    exit 1
end

DRIVE_ID = ARGV[0].to_s
DRIVE_SECRET = ARGV[1].to_s
JIRA_FILTER_URL = ARGV[2].to_s
JIRA_LOGIN = ARGV[3].to_s
JIRA_PASSWORD = ARGV[4].to_s
JIRA_FILTER_FILE_NAME = ARGV[5].to_s

session = GoogleDrive.saved_session("./stored_token.json", nil, DRIVE_ID, DRIVE_SECRET)
if session == ""
	exit 1
end

puts "querying jira filter for the excel export"
`curl -o #{JIRA_FILTER_FILE_NAME} -D- -u #{JIRA_LOGIN}:#{JIRA_PASSWORD} -X GET -H "Content-Type: application/json" #{JIRA_FILTER_URL}`

excelExists = false

# Gets list of remote files in this google account.
session.files.each do |file|
  if "#{file.title}" == "#{JIRA_FILTER_FILE_NAME}"
  	excelExists = true
  end
end

if excelExists == false
	puts "uploading #{JIRA_FILTER_FILE_NAME} to google_drive"
	session.upload_from_file("#{JIRA_FILTER_FILE_NAME}", "#{JIRA_FILTER_FILE_NAME}", convert: true)
else
	puts "updating #{JIRA_FILTER_FILE_NAME} in google_drive"
	file = session.file_by_title("#{JIRA_FILTER_FILE_NAME}")
	file.update_from_file("#{JIRA_FILTER_FILE_NAME}")
end