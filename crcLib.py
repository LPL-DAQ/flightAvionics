from crc import Calculator, Crc8

class CRC:
	def encode_crc(data):

		calculator = Calculator(Crc8.CCITT, optimized=True)
		return calculator.checksum(data)

	def check_crc(data,crc_byte):
		err = 0
		calculator = Calculator(Crc8.CCITT, optimized=True)

		if crc_byte != calculator.checksum(data)
			err = -1

		return err