<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" encoding="UTF-8"/>
    <xsl:template match="BIGVIR">
        <liste_personnes>
            <infos>Les <xsl:value-of select="count(LISTE_CITOYEN/CITOYEN[descendant::STATUT_INFECTION='INFECTE' and descendant::STATUT_IMMUNISATION='IMMUNISE'])" /> citoyen(s) immunisé(s) qui ont le BIGVIR</infos>
            <xsl:apply-templates select="LISTE_CITOYEN/CITOYEN[descendant::STATUT_INFECTION='INFECTE' and descendant::STATUT_IMMUNISATION='IMMUNISE']" />
        </liste_personnes>
    </xsl:template>

    <xsl:template match="CITOYEN">
        <citoyen>
            <nom><xsl:value-of select="NOM" /></nom>
            <prenom><xsl:value-of select="PRENOM" /></prenom>
        </citoyen>
    </xsl:template>
</xsl:stylesheet>