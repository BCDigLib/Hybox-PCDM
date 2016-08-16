<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0" xmlns:mets="http://www.loc.gov/METS/" xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:xlink="http://www.w3.org/1999/xlink">

    <xsl:output method="text"/>
    <xsl:key name="fileIDs" match ="mets:mets/mets:fileSec/mets:fileGrp/mets:file" use="@ID"/>
    <xsl:template match="/">
        <xsl:variable name="objectURI" select="mets:mets/@OBJID"/>
        <xsl:text>
            {
                "@context":
                {
                 "pcdm":"http://pcdm.org/models#",
                 "pcdmuse":"http://pcdm.org/use#",
                 "mods":"http://www.loc.gov/mods/v3",
                 "ore": "http://www.openarchives.org/ore/terms/",
                 "iana": "http://www.iana.org/assignments/relation/"
                },
                "@type":"pcdm:Collection",
                "@id":"http://bc.edu/</xsl:text>
        <xsl:value-of select="mets:mets/@OBJID"/>
        <xsl:text>",
                "mods:title":"</xsl:text>
        <xsl:value-of select="mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/mods:mods/mods:titleInfo/mods:title"/>
        <xsl:text>",
                "pcdm:hasMember":[</xsl:text>
        <xsl:for-each select="mets:mets/mets:structMap/mets:div/mets:div/mets:div">
            <xsl:text>
                    {"@id":"http://</xsl:text><xsl:value-of select="$objectURI"/>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="@LABEL"/>
            <xsl:text>", "@type":"pcdm:Object","pcdm:HasFileSet":
                        {"@id":"http://</xsl:text><xsl:value-of select="$objectURI"/>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="@LABEL"/>
            <xsl:text>/images",
                        "@type":"pcdm:Object",
                        "pcdm:memberOf":"http://</xsl:text><xsl:value-of select="$objectURI"/>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="@LABEL"/>
            <xsl:text>",
                        "pcdm:hasFile":[</xsl:text>
            <xsl:for-each select="mets:fptr">
                <xsl:text>
                            {"@id":"</xsl:text>
                <xsl:for-each select="key('fileIDs', @FILEID)">
                    <xsl:value-of select="mets:FLocat/@xlink:href"/>
                    <xsl:text>", "mods:type":"</xsl:text>
                    <xsl:value-of select="@MIMETYPE"/>
                    <xsl:text>", "pdcmuse":"</xsl:text>
                    <xsl:choose>
                        <xsl:when test="@MIMETYPE='image/tiff'">
                            <xsl:text>PerservationMasterFile</xsl:text>
                        </xsl:when>
                        <xsl:when test="@MIMETYPE='image/jp2'">
                            <xsl:text>ServiceFile</xsl:text>
                        </xsl:when>
                        <xsl:when test="@MIMETYPE='image/jpeg'">
                            <xsl:text>ServiceFile</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
                <xsl:text>", "pcdm:memberOf":"http://</xsl:text><xsl:value-of select="$objectURI"/>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="../@LABEL"/>
                <xsl:text>/images</xsl:text>
                <xsl:choose>
                    <xsl:when test="position() = last()">
                        <xsl:text>"}</xsl:text>
                    </xsl:when>
                    <xsl:otherwise><xsl:text>"},</xsl:text></xsl:otherwise>
                </xsl:choose>    
            </xsl:for-each>
            <xsl:text>
                            ]
                        }
            </xsl:text>
            <xsl:choose>
                <xsl:when test="position() = last()">
                    <xsl:text>        }</xsl:text>
                </xsl:when>
                <xsl:otherwise><xsl:text>        },
                </xsl:text></xsl:otherwise>
            </xsl:choose>  
        </xsl:for-each>
        <xsl:text>
                ],
                "iana:first":"http://</xsl:text>
        <xsl:value-of select="$objectURI"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="mets:mets/mets:structMap/mets:div/mets:div/mets:div[1]/@LABEL"/>
        <xsl:text>/proxy",
                "iana:last":"http://</xsl:text>
        <xsl:value-of select="$objectURI"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="mets:mets/mets:structMap/mets:div/mets:div/mets:div[last()]/@LABEL"/>
        <xsl:text>/proxy",
                "pcdm:AlternateOrder": [</xsl:text>
        <xsl:for-each select="mets:mets/mets:structMap/mets:div/mets:div/mets:div">
            <xsl:text>
                    {
                        "@id":"http://</xsl:text>
            <xsl:value-of select="$objectURI"/><xsl:text>/</xsl:text>
            <xsl:value-of select="@LABEL"/>
            <xsl:text>/proxy",
                        "@type":"ore:proxy",
                        "ore:proxyFor":"http://</xsl:text>
            <xsl:value-of select="$objectURI"/><xsl:text>/</xsl:text>
            <xsl:value-of select="@LABEL"/><xsl:text>",
                        "ore:proxyIn":"http://</xsl:text>
            <xsl:value-of select="$objectURI"/><xsl:text>",</xsl:text>
            <xsl:choose>
                <xsl:when test="position()=1">
                    <xsl:text>
                        "iana:next":"http://</xsl:text>
                    <xsl:value-of select="$objectURI"/><xsl:text>/</xsl:text>
                    <xsl:value-of select="following-sibling::mets:div/@LABEL"/>
                    <xsl:text>"
                    },</xsl:text>
                </xsl:when>
                <xsl:when test="position()=last()">
                    <xsl:text>
                        "iana:prev":"http://</xsl:text>
                    <xsl:value-of select="$objectURI"/><xsl:text>/</xsl:text>
                    <xsl:value-of select="preceding-sibling::mets:div[1]/@LABEL"/>
                    <xsl:text>"
                    }
                ]</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>
                        "iana:prev":"http://</xsl:text>
                    <xsl:value-of select="$objectURI"/><xsl:text>/</xsl:text>
                    <xsl:value-of select="preceding-sibling::mets:div[1]/@LABEL"/>
                    <xsl:text>",
                        "iana:next":"http://</xsl:text>
                    <xsl:value-of select="$objectURI"/><xsl:text>/</xsl:text>
                    <xsl:value-of select="following-sibling::mets:div/@LABEL"/>
                    <xsl:text>"
                    },</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        <xsl:text>
            }
        </xsl:text>
    </xsl:template>
</xsl:stylesheet>