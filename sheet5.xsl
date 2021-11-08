<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="ISO-8859-1"/>
    <xsl:template match="/BIGVIR">
        <head>
            <title>Tous les citoyens non vaccinés qui ont le BIGVIR, triés par age croissant</title>
        </head>
        <body style="text-align : center">
            <h1>Les <xsl:value-of select="count(LISTE_CITOYEN/CITOYEN[STATUT_VACCINATION='NON_VACCINE' and STATUT_INFECTION='INFECTE'])"/> citoyens non vaccinés qui ont le BIGVIR, triés par age croissant</h1>
            <div style="display:flex; justify-content:center;">
                <xsl:apply-templates select="LISTE_CITOYEN/CITOYEN[STATUT_VACCINATION='NON_VACCINE' and STATUT_INFECTION='INFECTE']"/>
            </div>
        </body>
    </xsl:template>

    <xsl:template match="CITOYEN">
        <div style="margin:10px; padding:10px; border:solid;">
            <h2><strong>Age : </strong> <xsl:value-of select="AGE"/> ans</h2>
            <p><strong>Nom : </strong><xsl:value-of select="NOM"/>  </p>
            <p><strong>Prénom : </strong><xsl:value-of select="PRENOM"/></p>
            <p><strong>Poids : </strong> <xsl:value-of select="POIDS"/> kg</p>
            <p><strong>Téléphone : </strong> <xsl:value-of select="TELEPHONE"/></p>
        </div>
    </xsl:template>
</xsl:stylesheet>
