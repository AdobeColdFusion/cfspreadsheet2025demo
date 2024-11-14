component spreadsheet{
    // Read files out of directory, create links to display the data
    public function displayDataFiles(){
        // 
        filteredResults = directoryList("#request.rootdiskPath#data", true, "query");
        dataitem = "<ul>";
        for (item in filteredResults){ // Here we build the links which will allow you to view the data from each CSV.
            dataItem = dataItem & "<li>";
            dataItem = dataItem & "<form>";
            dataItem = dataItem & "<input type='hidden' name='filetoview' value='#request.datadiskpath#/#item.name#' />";
            dataItem = dataItem & "<button class='button is-ghost' hx-post='displaydata.cfm' hx-target='##viewcontainer'>";
            dataItem = dataItem & item.name;
            dataItem = dataItem & "</button>";
            dataItem = dataItem & "</form>";
            dataItem = dataItem & "</li>";
        }
        dataitem = dataItem & "</ul>";
        writeOutput( dataItem );
        return false;
    }
    public function displayDataFilesForEdit(){
        // 
        filteredResults = directoryList("#request.rootdiskPath#data", true, "query");
        dataitem = "<ul>";
        for (item in filteredResults){ // Here we build the links which will allow you to view the data from each CSV.
            dataItem = dataItem & "<li>";
            dataItem = dataItem & "<form>";
            dataItem = dataItem & "<input type='hidden' name='filetoview' value='#request.datadiskpath#/#item.name#' />";
            dataItem = dataItem & "<button class='button is-ghost' hx-post='editdata.cfm' hx-target='##viewcontainer'>";
            dataItem = dataItem & item.name;
            dataItem = dataItem & "</button>";
            dataItem = dataItem & "</form>";
            dataItem = dataItem & "</li>";
        }
        dataitem = dataItem & "</ul>";
        writeOutput( dataItem );
        return false;
    }
    public function displayDataFilesForSearch(){
        // 
        filteredResults = directoryList("#request.rootdiskPath#data", true, "query");
        dataitem = "<ul>";
        dataItem = dataItem & "<li>";
        dataItem = dataItem & "<form>";
        dataItem = dataItem & "<select name='filename' id='filename' class='input'>";
        for (item in filteredResults){ // Here we build the links which will allow you to view the data from each CSV.
            dataItem = dataItem & "<option value='#item.name#'>" & item.name & "</option>";
            dataItem = dataItem & item.name;
            dataItem = dataItem & "";
        }
        dataItem = dataItem & "</select><div class='block'></div>";
        dataItem = dataItem & "<input type='text' name='searchparam' class='input' id='searchparam' value='' />"
        dataItem = dataItem & "<button class='button is-ghost' hx-post='searchcsvfile.cfm' hx-target='##viewcontainer'>SEARCH CSV</button>";
        dataItem = dataItem & "</form>";
        dataItem = dataItem & "</li>";
        dataitem = dataItem & "</ul>";
        writeOutput( dataItem );
        return false;
    }
    public function displayDataAsTable(required string fileName){
        try {
            theCSVFile = getDirectoryFromPath(GetCurrentTemplatePath()) & "#fileName#"; // Grab the value of the location of the file
            format = "query"; // Set format type.
            csvObj = csvread(filepath = theCSVFile, outputformat = format); // Read CSV into memory
            QueryMetaDataArray = GetMetaData(csvObj); // Since we don't know the structure, we need the meta data.
            GetQueryColCount = arrayLen(QueryMetaDataArray);
            headerArray=[]; 
            for (row in csvObj){
                if (csvObj.currentRow > 1){ // Test whether we are on the first row (assuming headers are in first record). If not, break loop.
                    break;
                }
                for (colname in QueryMetaDataArray) // Loop through the meta data to get the total number of columns. Use that info to create a header array.
                    {
                        colnameeach = colname.Name; // Grab the column name from the struct
                        colvalue = csvObj[colnameeach][csvObj.currentRow]; // Grab the value in the first row at that column position
                        arrayAppend(headerArray, "#colvalue#"); // Append it to our header array
                    }
            }
            readconfiguration={ "header"=#headerArray#, "skipHeaderRecord" = 1 } // Set csvformat to header info, ignore header row
            csvForOutput = csvread(filepath = theCSVFile, outputformat = format, csvformatconfiguration = readconfiguration); // Re-read the CSV, but this time set the headers correctly and ignore the first row
        }
        catch(any e){
            writeDump(e)
        }
        orderedQuery = QueryExecute("select * from csvForOutput",{datasource="csvObj"}, {dbtype="query"});
        tablevar = '';
        tablevar = '<table id="datatable" class="table table is-bordered table is-striped table is-fullwidth"><thead><tr>'; // start off the table
        for (headers in headerArray){
            tablevar = tablevar & "<th>" & headers & "</td>"; //dynamically build the header of the table as needed
        }
        tablevar = tablevar & "</tr></thead>"; // Close off the table header
        tablevar = tablevar & "<tbody>";
        for (datarows in orderedQuery){
            tablevar = tablevar & "<tr>";
            for (colname in headerArray){
                tablevar = tablevar & "<td>" & orderedQuery[colname][orderedQuery.currentRow] & "</td>";
            }
            tablevar = tablevar & "</tr>";
        }
        tablevar = tablevar & "</tbody></table>";
        writeoutput(tablevar);
    }
    public function editCSV(required string fileName){
        try {
            theCSVFile = getDirectoryFromPath(GetCurrentTemplatePath()) & "#fileName#"; // Grab the value of the location of the file
            format = "csvstring"; // Set format type.
            csvObj = csvread(filepath = theCSVFile, outputformat = format); // Read CSV into memory
        }
        catch(any e){
            writeDump(e)
        }
        previewcode = "";
        previewcode = previewcode & "<form>";
        previewcode = previewcode & "<input type='hidden' name='filename' value='" & theCSVFile & "'>";
        previewcode = previewcode & "<button class='button is-warning' id='btnsave' name='btnsave' hx-post='savecsvedits.cfm' hx-target='##viewcontainer'>SAVE CHANGES</button><div class='block'>&nbsp;</div>";
        previewcode = previewcode & "<textarea id='csvtext' name='csvtext' class='textareaedit'>" & csvObj & "</textarea>";
        previewcode = previewcode & "</form>";
        writeoutput(previewcode);
    }
    public function previewcsv(required string csvtext, required string csvname){
        theFile= request.rootdiskPath & "tempdata\" & csvname & ".csv";
        tempfilelocation =  "tempdata/" & csvname & ".csv";
        format = "csvstring"; // Set format type.
        csvwrite(csvtext, format, #theFile#); // write CSV to temporary folder on disk
        displayDataAsTable(tempfilelocation); // preview CSV
    }
    public function savecsv(required string csvtext, required string csvname){
        theFile= request.rootdiskPath & "data\" & csvname & ".csv";
        deleteFromTempFile = request.rootdiskPath & "tempdata\" & csvname & ".csv";
        format = "csvstring"; // Set format type.
        csvwrite(csvtext, format, #theFile#); // write CSV to disk
        try {
            fileDelete(deleteFromTempFile); // Try to delete the file from temp folder
        }
        catch(any e){
            // If it isn't there, no worries
        }
        // Reset the UI
        writeOutput("<script>");
        writeOutput("window.location = " & request.rootappPath);
        writeOutput("</script>");
    }
    public function saveeditcsv(required string csvtext, required string csvname){
        theFile= csvname;
        format = "csvstring"; // Set format type.
        csvwrite(csvtext, format, #theFile#); // write CSV to disk
        // Reset the UI
        writeOutput("<script>");
        writeOutput("window.location = " & request.rootappPath);
        writeOutput("</script>");
    }
    public function searchcsvfile(required string filename, required string searchparam){
        numfoundtemp = 0;
        theFile = getDirectoryFromPath(GetCurrentTemplatePath()) & "data/#fileName#";
        format = "query"; // Set format type.
        csvObj = csvread(filepath = theFile, outputformat = format); // Read CSV into memory
        QueryMetaDataArray = GetMetaData(csvObj); // Since we don't know the structure, we need the meta data.
        GetQueryColCount = arrayLen(QueryMetaDataArray);
        headerArray=[]; 
        for (row in csvObj){
            if (csvObj.currentRow > 1){ // Test whether we are on the first row (assuming headers are in first record). If not, break loop.
                break;
            }
            for (colname in QueryMetaDataArray) // Loop through the meta data to get the total number of columns. Use that info to create a header array.
                {
                    colnameeach = colname.Name; // Grab the column name from the struct
                    colvalue = csvObj[colnameeach][csvObj.currentRow]; // Grab the value in the first row at that column position
                    arrayAppend(headerArray, "#colvalue#"); // Append it to our header array
                }
        }
        tablestring = '';
        tablestring = tablestring & '<table id="datatable" class="table table is-bordered table is-striped table is-fullwidth"><thead><tr>'; // start off the table
        for (headers in headerArray){
            tablestring = tablestring & "<th>" & headers & "</td>"; //dynamically build the header of the table as needed
        }
        tablestring = tablestring & "</tr></thead>"; // Close off the table header
        tablestring = tablestring & "<tbody>";
        CSVProcess(filepath = #theFile#, rowprocessor = (row,rowNumber)=>{
            index = 0
            for(item in row){
                if(findNoCase("#searchparam#",item)){
                    index = 1;
                    numfoundtemp++;  
                }
            } 
            if(index == 1){
                tablestring = tablestring & '<tr>';
                    for(item in row){
                        tablestring = tablestring & '<td>';
                        tablestring = tablestring & item;
                        tablestring = tablestring & '</td>';
                    } 
                tablestring = tablestring & '</tr>';
            }
        },
        rowFilter = (row,rowNumber)=> {
            return true;
        },csvformatconfiguration={})
        tablestring = tablestring & '</tbody></tr></table>'
        writeOutput("Number of entries for search in file <strong>" & filename & "</strong> is " & numfoundtemp) & "<br /><br />";
        writeOutput(tablestring);
    }
}