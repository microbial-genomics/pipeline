import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Random;

public class SampleSequence {

	public static void main(String[] args) {
		
		try {
			LinkedList list = new LinkedList();
			String fileName = args[0];
			//String fileName = "C:\\Users\\tshaw\\Desktop\\Kelvin_Metagenomics\\SecondManuscript\\NBC.fasta";
			
			FileInputStream fstream = new FileInputStream(fileName);
			DataInputStream din = new DataInputStream(fstream);
			BufferedReader in = new BufferedReader(new InputStreamReader(din));
			while (in.ready()) {
				String name = in.readLine();
				String seq = in.readLine();
				list.add(name + "\n" + seq + "\n");
			}
			in.close();
			
			String outputFile = args[1];
			//String outputFile = "C:\\Users\\tshaw\\Desktop\\Kelvin_Metagenomics\\SecondManuscript\\G1-7U-15_S11_L001_merge_resample.fasta";
			FileWriter fwriter = new FileWriter(outputFile);
			BufferedWriter out = new BufferedWriter(fwriter);
			
			String tag = args[2];
			int count = new Integer(args[3]);
			int n = 11467;
			while (count > 0) {
				Random rand = new Random();
				int num = rand.nextInt(list.size());
				String str = (String)list.get(num);
				str = str.replaceAll(">", "");
				//str = ">G1.7U.15_" + n + " " + str;
				str = ">" + tag + "_" + n + " " + str;
				n++;
				out.write(str);
				list.remove(num);
				count--;
			}
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
