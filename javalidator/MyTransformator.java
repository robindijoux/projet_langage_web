package javalidator;

import java.io.*;
import javax.xml.transform.*;
import javax.xml.transform.stream.*;
import javax.xml.transform.stream.StreamSource;
import java.nio.file.PathMatcher;
import java.nio.file.Paths;
import java.time.Instant;
import java.nio.file.FileSystems;
import java.nio.file.Files;


public class MyTransformator {

    static String outFilename, outExtension, xslFilename;

    static final String inFilename = "../sample_garrot_dijoux_BigVir2084.xml";

    static final String transfoDirPath = "./transfos/";

    /**
     * Utilisé pour vérifier l'extension du fichiers xsl passés en paramètres.
     */
    static final PathMatcher matcher = FileSystems.getDefault().getPathMatcher("glob:**.xsl");
    

    /**
     * code inspiré du site StackOverflow https://stackoverflow.com/questions/5977846/how-to-apply-xsl-to-xml-in-java
     * 
     * L'appel doit prendre en paramètre le fichier CHEMIN_VERS_FICHIER_XSL.xsl.
     */
 
    public static void main(String[]args) {

        processInputs(args);

        try {
            TransformerFactory factory = TransformerFactory.newInstance();

            Templates template = factory.newTemplates(new StreamSource(
                new FileInputStream(xslFilename)));
            
            Transformer xformer = template.newTransformer();

            // on créé le répertoire des transformations
            Files.createDirectories(Paths.get(transfoDirPath));

            // on récupère l'extension demandée par le fichier .xsl
            outExtension = template.getOutputProperties().getProperty("method")!=null ? template.getOutputProperties().getProperty("method") : "xml";

            outFilename = transfoDirPath + "transfo_" + Instant.now().toEpochMilli()/10 + "." + outExtension;

            Source source = new StreamSource(new FileInputStream(inFilename));
            Result result = new StreamResult(new FileOutputStream(outFilename));

            xformer.transform(source, result);
            System.out.println("Fichier "+ outFilename + " créé avec succès.");
        } catch (Exception e){
            e.printStackTrace();
            System.exit(1);
        }
    }

    private static void processInputs(String[] args) {
        if (args.length!=1 || !matcher.matches(FileSystems.getDefault().getPath(args[0]))) {
            System.err.println("Donnez en paramètre le fichier xsl qui servira a la transformation.");
            System.exit(1);
        }
        xslFilename = args[0];
    }
}