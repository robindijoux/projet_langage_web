package javalidator;

import java.io.File;
import java.util.Map;

import javax.xml.XMLConstants;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import java.nio.file.PathMatcher;
import java.nio.file.FileSystems;

public class MyValidator {

    static final String DEFAULT_XSD_PATH = "../../schema_garrot_dijoux_BigVir2084.xsd";
    static final String DEFAULT_XML_PATH = "../../sample_garrot_dijoux_BigVir2084.xml";

    static enum Options {
        XSD, XML
    }

    /**
     * Utilisé pour vérifier l'extension des fichiers passés en paramètres.
     */
    static final Map<Options, PathMatcher> pathMatcherMap = Map.of(
        Options.XSD, FileSystems.getDefault().getPathMatcher("glob:**.xsd"),
        Options.XML, FileSystems.getDefault().getPathMatcher("glob:**.xml")
    );

    /**
     * Utilisé pour vérifier les options passées.
     */
    static final Map<Options, String> oMap = Map.of(
        Options.XSD, "-xsd",
        Options.XML, "-xml"
    );

    /**
     * code inspiré du site JournalDuDev https://www.journaldev.com/895/how-to-validate-xml-against-xsd-in-java
     * 
     * L'appel peut prendre deux options et deux paramètres
     * 
     * L'option -xml CHEMIN_VERS_FICHIER_XML.xml pour spécifier un fichier xml à valider,
     * et l'option -xsd CHEMIN_VERS_FICHIER_XSD.xsd pour spécifier un fichier xsd à faire valider.
     * 
     * Si les options ne sont pas spécifiées, les fichiers par défaut seront utilisés.
     */
    public static void main(String[] args) {
        String xsdPath = DEFAULT_XSD_PATH, xmlPath = DEFAULT_XML_PATH;

        switch (args.length){
            case 0 :
                break;
            case 2:
                if (isXsdOptionGiven(args[0])){
                    if (pathMatcherMap.get(Options.XSD).matches(FileSystems.getDefault().getPath(args[1]))) xsdPath = args[1];
                    else {
                        System.err.println(args[1] + " n'est pas un fichier xsd.");
                        return;
                    }
                } else if (isXmlOptionGiven(args[0])){
                    if (pathMatcherMap.get(Options.XML).matches(FileSystems.getDefault().getPath(args[1]))) xmlPath = args[1];
                    else {
                        System.err.println(args[1] + " n'est pas un fichier xml.");
                        return;
                    }
                } else {
                    System.err.println(args[0] + " n'est pas une option valide.\nLes options valides sont -xml CHEMIN_VERS_FICHIER_XML et/ou -xsd CHEMIN_VERS_FICHIER_XSD.");
                    return;
                }
                break;
            case 4:
                if (isXsdOptionGiven(args[0]) && isXmlOptionGiven(args[2])){
                    if (pathMatcherMap.get(Options.XSD).matches(FileSystems.getDefault().getPath(args[1]))
                            && pathMatcherMap.get(Options.XML).matches(FileSystems.getDefault().getPath(args[3]))) {
                        xsdPath = args[1];
                        xmlPath = args[3];
                        break;
                    } else {
                        System.err.println("Fichier(s) "+args[1] + " et/ou " + args[3] + " invalide(s) pour l'option associée.");
                        return;
                    }
                } else if (isXsdOptionGiven(args[2]) && isXmlOptionGiven(args[0])){
                    if (pathMatcherMap.get(Options.XSD).matches(FileSystems.getDefault().getPath(args[3]))
                    && pathMatcherMap.get(Options.XML).matches(FileSystems.getDefault().getPath(args[1]))) {
                        xsdPath = args[3];
                        xmlPath = args[1];
                        break;
                    } else {
                        System.err.println("Fichier(s) "+args[1] + " et/ou " + args[3] + " invalide(s) pour l'option associée.");
                        return;
                    }
                } else {
                    System.err.println("Option(s) invalide(s).\nLes options valides sont -xml CHEMIN_VERS_FICHIER_XML.xml et/ou -xsd CHEMIN_VERS_FICHIER_XSD.xsd");
                    return;
                }
            default:
                System.err.println("Option(s) invalide(s).\nLes options valides sont -xml CHEMIN_VERS_FICHIER_XML.xml et/ou -xsd CHEMIN_VERS_FICHIER_XSD.xsd");
                return;
        }

        if (validateXMLSchema(xsdPath, xmlPath)) System.out.println("Le fichier xml " + xmlPath + " valide le schéma " + xsdPath);
        else System.out.println("Le fichier xml " + xmlPath + " ne valide pas le schéma " + xsdPath);
    }

    /**
     * Renvoie true si option correspond à l'option -xsd
     * 
     * @param option
     * @return
     */
    static boolean isXsdOptionGiven(String option){
        return option.equals(oMap.get(Options.XSD));
    }

    /**
     * Renvoie true si option correspond à l'option -xml
     * 
     * @param option
     * @return
     */
    static boolean isXmlOptionGiven(String option){
        return option.equals(oMap.get(Options.XML));
    }
    
    public static boolean validateXMLSchema(String xsdPath, String xmlPath){
        try {
            SchemaFactory factory = 
                    SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema = factory.newSchema(new File(xsdPath));
            Validator validator = schema.newValidator();
            validator.validate(new StreamSource(new File(xmlPath)));
        } catch (Exception e) {
            System.out.println("Error: "+e.getMessage());
            System.exit(1);
        }
        return true;
    }
}