<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" encoding="UTF-8"/>
    <xsl:template match="BIGVIR">
        <HISTORIQUES_RESULTATS_BIGVIR>
            <xsl:apply-templates select="LISTE_CITOYEN/CITOYEN/ANTECEDENTS_MECICAUX/RESULTATS_TESTS_LABORATOIRE/RESULTAT"/>
        </HISTORIQUES_RESULTATS_BIGVIR>
    </xsl:template>

    <xsl:template match="RESULTAT">
        <xsl:element name="RESULTAT">
            <xsl:attribute name="id_resultat"><xsl:value-of select="@id_resultat"/></xsl:attribute>
            <PATIENT><xsl:value-of select="../../../NOM"/>, <xsl:value-of select="../../../PRENOM"/></PATIENT>
            <ID_PATIENT><xsl:value-of select="../../../@id_citoyen"/></ID_PATIENT>
            <xsl:copy-of select="node()"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
