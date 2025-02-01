## jq --from-file
## filermeta-parse.jq
## Parse filer metadata updates to give simple human-readable change indicators.
if (
	(.eventNotification.oldEntry | not) 
    and .eventNotification.newEntry 
) then
    [ "[Create] ",
	.eventNotification.newParentPath, "/", .eventNotification.newEntry.name 
	] | join("") 
elif (
	.eventNotification.oldEntry
	and .eventNotification.newEntry 
	and .directory
	and .eventNotification.newParentPath
) then
	[ "[Rename] ",
    .directory, "/", .eventNotification.oldEntry.name,
    " to ",
    .eventNotification.newParentPath, "/", .eventNotification.newEntry.name
    ] | join("")
elif (
    .eventNotification.oldEntry
    and .eventNotification.newEntry 
) then
    [ "[Update] ",
    .eventNotification.newParentPath, "/", .eventNotification.newEntry.name
    ] | join("")
elif (
	.eventNotification.oldEntry
	and (.eventNotification.newEntry | not)
) then
    [ "[Delete] ",
    .directory, "/", .eventNotification.oldEntry.name
    ] | join("")
else 
	[ "[Unrecognized message] ",
	. ]
end
