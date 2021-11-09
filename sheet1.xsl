<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="ISO-8859-1"/>
    <xsl:template match="/BIGVIR">
        <head>
            <title>Les consultations de Robin Dijoux</title>
        </head>
        <body style="text-align : center; background-color: #d5f4e6">
            <h1>Les <xsl:value-of select="count(LISTE_CITOYEN/CITOYEN[NOM='DIJOUX']/ANTECEDENTS_MECICAUX/CONSULTATIONS/CONSULTATION)"/> consultations de Robin Dijoux</h1>
            <xsl:apply-templates select="LISTE_CITOYEN/CITOYEN[NOM='DIJOUX']"/>
        </body>
    </xsl:template>

    <xsl:template match="CITOYEN">
        <div>
            <h2>Informations sur le citoyen</h2>
            <p><strong>Nom :</strong><xsl:value-of select="NOM"/>  </p>
            <p><strong>Prénom :</strong><xsl:value-of select="PRENOM"/></p>
            <p><strong>Age :</strong> <xsl:value-of select="AGE"/> ans</p>
            <p><strong>Poids :</strong> <xsl:value-of select="POIDS"/> kg</p>
            <p><strong>Téléphone :</strong> <xsl:value-of select="TELEPHONE"/></p>
        </div>
        <xsl:apply-templates select="ANTECEDENTS_MECICAUX/CONSULTATIONS/CONSULTATION"/>
    </xsl:template>

    <xsl:template match="CONSULTATION">
        <div style="background-color: #618685; border : 2px solid white; color:white; display : inline-block; padding : 4px">
            <h2>Consultation n°<xsl:value-of select="@id_consultation"/> : </h2>
            <p><strong>LIEU : </strong><xsl:value-of select="LIEU"/></p>
            <p><strong>DATE : </strong><xsl:value-of select="DATE"/></p>
            <p><strong>MOTIF : </strong><xsl:value-of select="MOTIF"/></p>
            <xsl:variable name="id_medecin" select="PROFESSIONNEL_SANTE/@professionnel_sante_id"/>
            <xsl:variable name="id_citoyen" select="/BIGVIR/LISTE_MEDECINS/MEDECIN[@id_medecin = $id_medecin]/@id_citoyen"/>
            <p>Réalisé par le docteur <xsl:value-of select="/BIGVIR/LISTE_CITOYEN/CITOYEN[@id_citoyen = $id_citoyen]/NOM"/></p>
        </div>
    </xsl:template>
</xsl:stylesheet>
