<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="ISO-8859-1"/>
    <xsl:template match="/BIGVIR">
        <head>
            <title>Toutes les personnes qui ont eu une activité avec plus de 10 personnes dans un lieu clos et qui ont été testées positives</title>
        </head>
        <body style="text-align : center; background-color: #d5f4e6">
            <h1>Les <xsl:value-of select="count(LISTE_CITOYEN/CITOYEN[descendant::ACTIVITE[NB_PARTICIPANTS>10 and LIEU_CLOS='true'] and descendant::RESULTAT[POSITIF='true']])"/> personnes qui ont eu une activité avec plus de 10 personnes dans un lieu clos et qui ont été testées positives.</h1>
            <xsl:apply-templates select="LISTE_CITOYEN/CITOYEN[descendant::ACTIVITE[NB_PARTICIPANTS>10 and LIEU_CLOS='true'] and descendant::RESULTAT[POSITIF='true']]">
            </xsl:apply-templates>
        </body>
    </xsl:template>

    <xsl:template match="CITOYEN">
        <div style="border : 2px solid white; display : inline-block; padding : 4px; background-color: #618685; color: white">
            <h2><strong><xsl:value-of select="NOM"/>, <xsl:value-of select="PRENOM"/></strong></h2>
            <span> à été(e) testé(e) <xsl:apply-templates select="descendant::RESULTAT[POSITIF='true'][1]"/></span>
            <br/>
            <span>et a participé à une activité <xsl:apply-templates select="descendant::ACTIVITE[NB_PARTICIPANTS>10 and LIEU_CLOS='true'][1]"/></span>
        </div>
    </xsl:template>

    <xsl:template match="RESULTAT">
        <strong>positif(ve) le <xsl:value-of select="DATE"/></strong>
    </xsl:template>

    <xsl:template match="ACTIVITE">
        avec <strong><xsl:value-of select="NB_PARTICIPANTS"/> personnes</strong> dans un lieu clos le <strong><xsl:value-of select="DATE"/></strong>
    </xsl:template>

</xsl:stylesheet>
