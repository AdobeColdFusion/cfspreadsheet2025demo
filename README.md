Demo application assets for CF25 beta launch.

To run this, do the following:

1) Download files to your cfusion director for CF25 in a folder named cf25demo-spreadsheet.
2) In that folder, create two more folders: "data" and "tempdata". Those will hold your CSVs.
3) In the application.cfc, make sure that the rootdiskPath, rootappPath, and datadiskpath all match your environment.
4) You can now put as many CSV files as you'd like in the "data" folder and the app will allow you to view, edit, and search them using the new CF25 features. You can also create a new CSV.

Notes:
- To create a CSV, the data you paste _must_ be in correct format. There is no testing of any fields right now.
- The search does a substring search of each array position.
- Most of the pages are making multiple calls to the CSVs they are viewing/editing. There are ERs in place to potentially improve this, but my solutions work.
- If you find a bug or improvement to the functionality here, please do a PR after testing that it works in all environments.
