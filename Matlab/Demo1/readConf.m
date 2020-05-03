function cf = readConf(xmlDoc,name)
    cf=str2double(xmlDoc.getElementsByTagName(name).item(0).getFirstChild.getData);
end