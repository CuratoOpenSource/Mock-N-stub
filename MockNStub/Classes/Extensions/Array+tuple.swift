internal extension Array {
    
    var tuple: Any {
        switch count {
        case 0:
            return ()
        case 1:
            return (self[0])
        case 2:
            return (self[0], self[1])
        case 3:
            return (self[0], self[1], self[2])
        case 4:
            return (self[0], self[1], self[2], self[3])
        case 5:
            return (self[0], self[1], self[2], self[3], self[4])
        case 6:
            return (self[0], self[1], self[2], self[3], self[4], self[5])
        case 7:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6])
        case 8:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7])
        case 9:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8])
        case 10:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9])
        case 11:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10])
        case 12:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10], self[11])
        case 13:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10], self[11], self[12])
        case 14:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10], self[11], self[12], self[13])
        case 15:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10], self[11], self[12], self[13], self[14])
        case 16:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10], self[11], self[12], self[13], self[14], self[15])
        case 17:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10], self[11], self[12], self[13], self[14], self[15], self[16])
        case 18:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10], self[11], self[12], self[13], self[14], self[15], self[16], self[17])
        case 19:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10], self[11], self[12], self[13], self[14], self[15], self[16], self[17], self[18])
        case 20:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10], self[11], self[12], self[13], self[14], self[15], self[16], self[17], self[18], self[19])
        case 21:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10], self[11], self[12], self[13], self[14], self[15], self[16], self[17], self[18], self[19], self[20])
        case 22:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10], self[11], self[12], self[13], self[14], self[15], self[16], self[17], self[18], self[19], self[20], self[21])
        case 23:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10], self[11], self[12], self[13], self[14], self[15], self[16], self[17], self[18], self[19], self[20], self[21], self[22])
        case 24:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10], self[11], self[12], self[13], self[14], self[15], self[16], self[17], self[18], self[19], self[20], self[21], self[22], self[23])
        default:
            logger.log("Can currently only create tuples from arrays with up to 24 elements. Elements at index 25 and up will be lost", atLevel: .warning)
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10], self[11], self[12], self[13], self[14], self[15], self[16], self[17], self[18], self[19], self[20], self[21], self[22], self[23])
        }
    }
}
