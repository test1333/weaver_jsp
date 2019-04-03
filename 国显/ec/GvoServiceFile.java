/**
 * 
 */
package gvo.passwd;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import weaver.file.multipart.MacBinaryDecoderOutputStream;


/**
 * @author Tony
 * 
 */
public class GvoServiceFile {

	public void getSourceFile(String filePath, String souceFile, String isZip)
			throws Exception {
		File thefile_gvo = new File(filePath);
		InputStream imagefile_gvo = null;
		ZipInputStream zin_gvo = null;
		if (isZip.equals("1")) {
			zin_gvo = new ZipInputStream(new FileInputStream(thefile_gvo));
			if (zin_gvo.getNextEntry() != null)
				imagefile_gvo = new BufferedInputStream(zin_gvo);
		} else {
			imagefile_gvo = new BufferedInputStream(new FileInputStream(
					thefile_gvo));
		}

		FileOutputStream fos = null;
		BufferedInputStream bis = null;
		int BUFFER_SIZE = 1024;
		byte[] buf = new byte[BUFFER_SIZE];
		int size = 0;
		bis = new BufferedInputStream(imagefile_gvo);
		fos = new FileOutputStream(souceFile, true);
		while ((size = bis.read(buf)) != -1)
			fos.write(buf, 0, size);

		if (fos != null)
			fos.close();
		if (bis != null)
			bis.close();
		if (zin_gvo != null)
			zin_gvo.close();
		if (imagefile_gvo != null)
			imagefile_gvo.close();

	}

	public void changeFile(String filePath, String lastPath, String isZip,
			String contentType) throws Exception {

		InputStream in = new FileInputStream(new File(filePath));
		OutputStream fileOut = null;
		if ("1".equals(isZip)) {
			ZipOutputStream filezipOut = new ZipOutputStream(
					new BufferedOutputStream(new FileOutputStream(lastPath)));
			filezipOut.setMethod(ZipOutputStream.DEFLATED); // ����ѹ������
			filezipOut.putNextEntry(new ZipEntry(new String(
					getPreName(lastPath).getBytes("GBK"), "ISO8859_1")));
			fileOut = filezipOut;
		} else
			fileOut = new BufferedOutputStream(new FileOutputStream(lastPath));
		if (contentType.equals("application/x-macbinary"))
			fileOut = new MacBinaryDecoderOutputStream(fileOut);
		int read;
		byte[] buf = new byte[8 * 1024];
		while ((read = in.read(buf)) != -1) {
			fileOut.write(buf, 0, read);
		}
		if (fileOut != null)
			fileOut.close();
		if (in != null)
			in.close();
	}

	private String getPreName(String filePath) {
		String filename = "";
		if (filePath != null && filePath.length() > 0) {
			int len = filePath.lastIndexOf("/") + 1;
			if (len <= 0)
				len = filePath.lastIndexOf("\\") + 1;
			int last = filePath.indexOf(".zip");
			if (last > len)
				filename = filePath.substring(len, last);
		}
		return filename;
	}

	/*
	 * pfile���жϵ��ļ� ����·��
	 * 
	 * ���ô���ʱ��Ĭ���ǲ�����״̬
	 * 
	 * ���� false��������״̬ true������״̬
	 */
	public boolean gvo_isEncrypt(String log_filename,String pfile) {
		
		return false;
	}

	public String gvo_isEncrypt(String log_filename,InputStream inputStream) {
		// ����·��
		String path = getPath();

		String fileName = path + getFileName();

		FileOutputStream fos = null;
		BufferedInputStream bis = null;
		int BUFFER_SIZE = 1024;
		byte[] buf = new byte[BUFFER_SIZE];
		int size = 0;
		try {
			bis = new BufferedInputStream(inputStream);
			fos = new FileOutputStream(fileName, true);
			while ((size = bis.read(buf)) != -1)
				fos.write(buf, 0, size);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (fos != null)
					fos.close();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			try {
				if (bis != null)
					bis.close();
			} catch (IOException e1) {
				e1.printStackTrace();
			}

		}

		boolean isEncrypt = gvo_isEncrypt(log_filename,fileName);
		if (isEncrypt) {
			String now_fileName = fileName + "_1";
			if(gvo_serviceFile(log_filename,fileName,now_fileName,false))
				return now_fileName;
		}
		return "";
	}

	/*
	 * log_filename ϵͳԭ�ļ�����
	 * sourceFile��ԭ�ļ� ������·���� nowFile : ������ļ� ������·���� isencfile : ����ʽ //false ����
	 * true ����
	 */
	
	public boolean gvo_serviceFile(String log_filename,String sourceFile, String nowFile,boolean isencfile) {
		return true;
	}

	// ���ܽ�����
	/*
	 * inputStream ԭ�ļ��� isPass : ����ʽ // false ���� true ���� ���أ� ���ܻ���ܺ���ļ���
	 */
	public InputStream getGvoInputStream(String log_filename,InputStream inputStream, boolean isPass) {
		// ����·��
		String path = getPath();
		
		String fileName = path + getFileName();

		FileOutputStream fos = null;
		BufferedInputStream bis = null;
		int BUFFER_SIZE = 1024;
		byte[] buf = new byte[BUFFER_SIZE];
		int size = 0;
		try {
			bis = new BufferedInputStream(inputStream);
			fos = new FileOutputStream(fileName, true);
			while ((size = bis.read(buf)) != -1)
				fos.write(buf, 0, size);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				fos.close();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			try {
				bis.close();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}

		String pfile = fileName + "_1";

		// String username = "dlltest";
		// String password = "test2014";
		//
		// // �ӽ��ܣ�����
		// boolean result =
		// Desinter.fileOperation(1,username,password,fileName,pfile,isPass);

		boolean result = gvo_serviceFile(log_filename,fileName, pfile, isPass);

		InputStream result_in = null;
		if (result) {
			try {
				result_in = new FileInputStream(new File(pfile));
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
		}

		// �Ƿ�Ҫɾ������
		return result_in;
	}

	public String getFileName() {

		// ��Զ���ظ��ļ��� ʱ�䡾1s�в���1000���� + �����ĸ��4���������ĸ��
		Format ft = new SimpleDateFormat("yyyyMMddHHmmssSSS");

		char x[] = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
				'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
				'X', 'Y', 'Z' };

		String str = ft.format(new Date());
		int max_length = x.length;
		Random rm = new Random();

		for (int i = 0; i < 4; i++) {
			str = str + x[rm.nextInt(max_length)];
		}

		return str;
	}

	public String getPath() {
		Format ft = new SimpleDateFormat("yyyy-MM");
		// ���ܻ�����
		String path = "D:\\\\ecologyTempCache\\\\" + ft.format(new Date()) + "\\\\";
	//	String path = "D:\\\\123\\\\" + ft.format(new Date()) + "\\\\";
		File f_apth = new File(path);
		if (!f_apth.exists()) {
			f_apth.mkdir();
		}
		return path;
	}
}
