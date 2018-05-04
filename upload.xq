(:BEGIN-SCRIPT-DOCUMENTATION
|TITLE Web Transform Tool
|CREATOR Joe Easterly
|UPDATED 2018-05-04
|DESCRIPTION This script uploads a file into an eXistdb collection, and provides a link to a script
             which transforms and then downloads the file. This tool is intended for digital scholarship
             projects where there is a regular need for one-at-a time XSLT transformations on XML files.
|DEPENDENCIES eXistdb, see http://exist-db.org
|LICENSE This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International
         License. To view a copy of this license, visit
         http://creativecommons.org/licenses/by-sa/4.0/.
END-SCRIPT-DOCUMENTATION
:)

declare option exist:serialize "method=xhtml media-type=text/html";
let $collection := concat(replace(replace(request:get-effective-uri(), 'upload.xq', ''),'/exist/rest',''),'uploaded-files')
let $filename := request:get-uploaded-file-name('file')
let $filepath := concat($collection, '/', $filename)
let $username := request:get-parameter('username', '')
let $password := request:get-parameter('password', '')

(: make sure you use the right user permissions that has write access to this collection :)
let $login := xmldb:login($collection, $username, $password)
let $store := xmldb:store($collection, $filename, request:get-uploaded-file-data('file'))

return
    <html>
        <head>
            <title>Upload</title>
        </head>
        <body>
            <h1>Upload successful</h1>
            <p>Your file has been uploaded. Click <a
                    href="download.xq?filepath={$filepath}&amp;filename={$filename}">here</a> to download a transformed version. 
                    If an error occurs while downloading, the most common reason is that "xml:id="1"" appears near the beginning
                    of line 4 and needs to be removed first.</p>
                    <p><a href="upload.html">back</a></p>
        </body>
    </html>
