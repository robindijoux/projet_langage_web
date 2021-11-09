<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" encoding="UTF-8"/>
    <xsl:template match="BIGVIR">
        <xsl:variable name="nb_infectés" select="count(LISTE_CITOYEN/CITOYEN[descendant::STATUT_INFECTION='INFECTE'])" />
        <xsl:variable name="nb_citoyens" select="count(LISTE_CITOYEN/CITOYEN)" />
        <donnes>
            <infos>
                <nb_citoyens><xsl:value-of select="$nb_citoyens"/></nb_citoyens>
                <pourcentage_infectés><xsl:value-of select="($nb_infectés div $nb_citoyens) * 100"/></pourcentage_infectés>
            </infos>
            <liste_citoyens_infectés>
                <xsl:apply-templates select="LISTE_CITOYEN/CITOYEN[descendant::STATUT_INFECTION='INFECTE']" />
            </liste_citoyens_infectés>
            <liste_citoyens_non_infectés>
                <xsl:apply-templates select="LISTE_CITOYEN/CITOYEN[descendant::STATUT_INFECTION='NON_INFECTE']" />
            </liste_citoyens_non_infectés>
        </donnes>
    </xsl:template>

    <xsl:template match="CITOYEN">
        <citoyen>
            <nom><xsl:value-of select="NOM" /></nom>
            <prenom><xsl:value-of select="PRENOM" /></prenom>
            <age><xsl:value-of select="AGE" /></age>
            <sexe><xsl:value-of select="SEXE" /></sexe>
        </citoyen>
    </xsl:template>
</xsl:stylesheet>