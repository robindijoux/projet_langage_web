<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="ISO-8859-1"/>
    <xsl:template match="/BIGVIR">
        <head>
            <title>Tous les établissements de capacité supérieure à 200 personnes triés par capacité</title>
        </head>
        <body style="text-align : center; background-color: #d5f4e6">
            <h1>Les <xsl:value-of select="count(LISTE_ETABLISSEMENTS/ETABLISSEMENT[NB_PLACES>200])"/> établissements de capacité supérieure à 200 personnes triés par capacité</h1>
            <xsl:apply-templates select="LISTE_ETABLISSEMENTS/ETABLISSEMENT[NB_PLACES>200]">
                    <xsl:sort select="NB_PLACES"/>
            </xsl:apply-templates>
        </body>
    </xsl:template>

    <xsl:template match="ETABLISSEMENT">
        <div style="border : 2px solid white; color: white; display : inline-block; padding : 4px; background-color: #618685;">
            <h2>Etablissement n°<xsl:value-of select="@id_etablissement"/> : </h2>
            <p><strong>Nom : </strong><xsl:value-of select="NOM_ETABLISSEMENT"/></p>
            <p><strong>Adresse : </strong><xsl:value-of select="ADRESSE"/></p>
            <p><strong>Superficie : </strong><xsl:value-of select="SUPERFICIE"/></p>
            <p><strong>Capacité : </strong><xsl:value-of select="NB_PLACES"/></p>
        </div>
    </xsl:template>
</xsl:stylesheet>
