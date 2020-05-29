package dev.codesquad.airbnb02;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@SpringBootApplication
@EntityScan
public class Airbnb02Application implements CommandLineRunner {

	public static void main(String[] args) {
		SpringApplication.run(Airbnb02Application.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor();
		pbeEnc.setAlgorithm("PBEWithMD5AndDES");
		pbeEnc.setPassword("test"); //2번 설정의 암호화 키를 입력

		String enc = pbeEnc.encrypt("airbnb02"); //암호화 할 내용
		System.out.println("airbnb02 = " + enc); //암호화 한 내용을 출력

		String enc2 = pbeEnc.encrypt("jdbc:mysql://localhost:3306/flyway");
		System.out.println("url = " + enc2);

		//테스트용 복호화
		String des = pbeEnc.decrypt(enc);
		System.out.println("des = " + des);
	}

}
