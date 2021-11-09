<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" encoding="ISO-8859-1"/>
    <xsl:template match="/BIGVIR/LISTE_CITOYEN">
        <LISTE_ETABLISSEMENTS>
            <xsl:for-each-group select="CITOYEN" group-by="HISTORIQUE_SOCIAL/ACTIVITE/REF_ETABLISSEMENT">
                <ETABLISSEMENT><!--id="{HISTORIQUE_SOCIAL/ACTIVITE/REF_ETABLISSEMENT}"-->
                    <xsl:for-each select="current-group()">
                        <VISITEUR>
                            <NOM><xsl:value-of select="NOM"/></NOM>
                            <PRENOM><xsl:value-of select="PRENOM"/></PRENOM>
                            <TELEPHONE><xsl:value-of select="TELEPHONE"/></TELEPHONE>
                            <INFECTE>
                                <xsl:when test="STATUT_INFECTION = 'INFECTE'">
                                    TRUE
                                </xsl:when>
                                <xsl:otherwise>
                                    FALSE
                                </xsl:otherwise>
                            </INFECTE>
                            <VACCINE>
                                <xsl:when test="STATUT_VACCINATION = 'VACCINE'">
                                    TRUE
                                </xsl:when>
                                <xsl:otherwise>
                                    FALSE
                                </xsl:otherwise>
                            </VACCINE>
                        </VISITEUR>
                    </xsl:for-each>
                </ETABLISSEMENT>
            </xsl:for-each-group>
        </LISTE_ETABLISSEMENTS>
    </xsl:template>
</xsl:stylesheet>

