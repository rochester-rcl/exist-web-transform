(:BEGIN-SCRIPT-DOCUMENTATION
|TITLE Web Transform Tool
|CREATOR Joe Easterly
|UPDATED 2018-05-04
|DESCRIPTION This script transforms an uploaded file with XSLT.
|LICENSE This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International
         License. To view a copy of this license, visit
         http://creativecommons.org/licenses/by-sa/4.0/.
END-SCRIPT-DOCUMENTATION
:)

xquery version "3.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=xml media-type=text/xml";
declare variable $filepath := request:get-parameter('filepath','');
declare variable $filename := request:get-parameter('filename','');
declare variable $download := response:set-header( "content-disposition", concat( "attachment; filename=", $filename ) );

  let $script := 'transform.xsl'
  let $params := 
<parameters>
    <param name="filepath" value="{$filepath}"/>
</parameters>

return
transform:transform(doc($filepath), doc($script), $params)