<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="ISO-8859-1"/>
    <xsl:template match="/BIGVIR">
        <head>
            <title>Liste des amis infectés par citoyen</title>
        </head>
        <body>
            <h1>Liste des amis infectés par citoyen</h1>
            <xsl:apply-templates select="LISTE_CITOYEN/CITOYEN"/>
        </body>
    </xsl:template>

    <xsl:template match="CITOYEN">
        <style type="text/css">
            table {
            border-collapse: collapse;
            margin : 10px;
            }
            th, td {
            border: 1px solid black
            }
            td {
            padding : 10px;
            }
        </style>
        <table>
            <th> <xsl:value-of select="NOM"/>, <xsl:value-of select="PRENOM"/></th>
            <xsl:for-each select="RELATIONS_SOCIALES/AMI">
                <xsl:variable name="id_ami" select="@id_ami"/>
                <xsl:if test="/BIGVIR/LISTE_CITOYEN/CITOYEN[@id_citoyen=$id_ami]/STATUT_INFECTION = 'INFECTE'">
                    <tr>
                        <td><xsl:value-of select="/BIGVIR/LISTE_CITOYEN/CITOYEN[@id_citoyen=$id_ami]/NOM"/></td>
                        <td><xsl:value-of select="/BIGVIR/LISTE_CITOYEN/CITOYEN[@id_citoyen=$id_ami]/PRENOM"/></td>
                    </tr>
                </xsl:if>
            </xsl:for-each>
        </table>
    </xsl:template>
</xsl:stylesheet>
