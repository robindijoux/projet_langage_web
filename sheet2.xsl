<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="ISO-8859-1"/>
    <xsl:template match="/BIGVIR">
        <head>
            <title>L'ensemble des hospitalisations triées par date</title>
        </head>
        <body style="text-align : center">
            <h1>Les <xsl:value-of select="count(LISTE_CITOYEN/CITOYEN/ANTECEDENTS_MECICAUX/HOSPITALISATIONS/HOSPITALISATION)"/> hospitalisations de la base de données triées par date</h1>
            <xsl:apply-templates select="LISTE_CITOYEN/CITOYEN/ANTECEDENTS_MECICAUX/HOSPITALISATIONS/HOSPITALISATION">
                    <xsl:sort select="DATE_ENTREE"/>
            </xsl:apply-templates>
        </body>
    </xsl:template>

    <xsl:template match="HOSPITALISATION">
        <div style="border : 2px solid black; display : inline-block; padding : 4px">
            <h2>Hospitalisation n°<xsl:value-of select="@id_hospitalisation"/> : </h2>
            <p><strong>PATIENT : </strong><xsl:value-of select="../../../NOM"/>, <xsl:value-of select="../../../PRENOM"/></p>
            <p><strong>LIEU : </strong><xsl:value-of select="LIEU"/></p>
            <p><strong>DATE D'ENTREE : </strong><xsl:value-of select="DATE_ENTREE"/></p>
            <p><strong>DATE DE SORTIE : </strong><xsl:value-of select="DATE_SORTIE"/></p>
            <p><strong>MOTIF : </strong><xsl:value-of select="MOTIF"/></p>
        </div>
    </xsl:template>
</xsl:stylesheet>
