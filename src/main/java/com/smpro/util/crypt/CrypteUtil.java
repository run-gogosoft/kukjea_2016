package com.smpro.util.crypt;

import org.springframework.stereotype.Component;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;

/**
 * AIRA algorithm to encrypt or decrypt the data is the class that provides the ability to.
 * @author shson
 *
 */
@Component
public class CrypteUtil {
	
	/**
	 * ARIA encryption algorithm block size
	 */
	private static final int ARIA_BLOCK_SIZE = 16;
	
	/**
	 * ARIA algorithm to encrypt the data.
	 * @param data Target Data
	 * @param key Masterkey
	 * @param keySize Masterkey Size
	 * @param charset Data character set
	 * @return Encrypted data
	 * @throws java.io.UnsupportedEncodingException If character is not supported
	 * @throws java.security.InvalidKeyException If the Masterkey is not valid
	 */
	public static String encrypt(String data, byte[] key, int keySize, String charset)
	throws UnsupportedEncodingException, InvalidKeyException {

		byte[] encrypt = null;
		if( charset == null ) {
			encrypt = BlockPadding.getInstance().addPadding(data.getBytes(), ARIA_BLOCK_SIZE);
		} else {
			encrypt = BlockPadding.getInstance().addPadding(data.getBytes(charset), ARIA_BLOCK_SIZE);
		}

		ARIAEngine engine = new ARIAEngine(keySize);
		engine.setKey(key);
		engine.setupEncRoundKeys();

		int blockCount = encrypt.length / ARIA_BLOCK_SIZE;
		for( int i = 0; i < blockCount; i++ ) {

			byte buffer[] = new byte[ARIA_BLOCK_SIZE];
			System.arraycopy(encrypt, (i * ARIA_BLOCK_SIZE), buffer, 0, ARIA_BLOCK_SIZE);

			buffer = engine.encrypt(buffer, 0);
			System.arraycopy(buffer, 0, encrypt, (i * ARIA_BLOCK_SIZE), buffer.length);
		}
		return Base64.toString(encrypt);
	}

	/**
	 * ARIA algorithm to decrypt the data.
	 * @param data Target Data
	 * @param key Masterkey
	 * @param keySize Masterkey Size
	 * @param charset Data character set
	 * @return Decrypted data
	 * @throws java.io.UnsupportedEncodingException If character is not supported
	 * @throws java.security.InvalidKeyException If the Masterkey is not valid
	 */
	public static String decrypt(String data, byte[] key, int keySize, String charset)
	throws UnsupportedEncodingException, InvalidKeyException {

		if(data == null || "".equals(data.trim())) {
			return null;
		}

		byte[] decrypt = Base64.toByte(data);
		
		ARIAEngine engine = new ARIAEngine(keySize);
		engine.setKey(key);
		engine.setupDecRoundKeys();
		
		int blockCount = decrypt.length / ARIA_BLOCK_SIZE;
		for( int i = 0; i < blockCount; i++ ) {
			
			byte buffer[] = new byte[ARIA_BLOCK_SIZE];
			System.arraycopy(decrypt, (i * ARIA_BLOCK_SIZE), buffer, 0, ARIA_BLOCK_SIZE);
			
			buffer = engine.decrypt(buffer, 0);
			System.arraycopy(buffer, 0, decrypt, (i * ARIA_BLOCK_SIZE), buffer.length);
		}
		
		if( charset == null ) {
			return new String(BlockPadding.getInstance().removePadding(decrypt, ARIA_BLOCK_SIZE));
		} 
		
		return new String(BlockPadding.getInstance().removePadding(decrypt, ARIA_BLOCK_SIZE), charset);
		
	}
}

