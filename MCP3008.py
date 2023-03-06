class MCP3008:
    def __init__(self,SPI_init):
        self.SPI = SPI_init

    def __readMCP3008(self, channel):
        #gets the raw 10-bit value from the MCP3008 ADC

        #request value from MCP3008 for channel number 'channel'
        rawData = self.SPI.xfer([1, (8 + channel) << 4, 0])

        #convert the two 8-bit replies to a single 10-bit reading
        #processedData = 0...1023
        processedData = ((rawData[1]&3) << 8) + rawData[2]

        return processedData

    def __dig2volts(self,digitalReading: int):
        #converts digital value (0...1023) to voltage (0...5V)
        voltage = (digitalReading * 5.365) / 1023
        return voltage
        #poll func
    def interrogate(self, channel):
        data = self.__readMCP3008(channel)
        voltage = self.__dig2volts(data)
        return (voltage, data)