<cfscript>
    obj = createObject("component","spreadsheets");
    invoke(obj,"searchcsvfile",{filename = form.filename,searchparam = form.searchparam});
</cfscript>