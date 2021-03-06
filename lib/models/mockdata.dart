import '../Hit.dart';

class MockData{

  static Hit getMockHit(){
    Hit hit = Hit();
    hit.accuracy = 15.0;
		hit.altitude = 1680.0;
		hit.frameContent = "iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAABHNCSVQICAgIfAhkiAAAA5xJREFUOBFFVNtu5DYUo+62x55MFrvYvvT/f6mfsEWxxSQzvulaHiVBBTh2NBIPRfJIAWiaf2RoKHg4zGrBMIyYrgbee0y3HzBGI1nAeQeTgFwKYo39Xc6/8Hg8sLWf4JL/h4B543EZLgQcYF3tgAKmtUEIFuM0Akfpm9aogPOEMpa/Bax7+wAUVGH5fSpkwMXxN4Jd8FYtHJkO0x9orSG1AaqNuMwG7+/vSOVvVBSc5USqCbZWWAEKfCqf8yxQKmEZX7HMCyorGzIbRrLld9YjnHOwrXTms5uxbTs0i1SC1Rp4KuUJ1eCMwWoOVKcxk/JRTwzLd1wuF2TPowwGV7Jx/L3sgFeK4nOG+w73E9k+4PIv6NgiWSkUimzJV5iIEdbSnHkmgO16ypyAi7YyQvCfrFo3TDQ23GsnsIKakWvGy/kOH/h/+BPNBwxkMM5XhJGbdKKOOwuT3XJF3amZMkhbxHNfsEeDb+3Bk9gBjWzEpckmXK9XaOfpqu5znt8haAJqXP3U2T2ftrOTNcLcl4YYU9fbPvIKkxU04zKZhqlVvLsT03QhSws9BSxa9SMqxdylzBMFZtJBxRmBGo71QMoFpEOnWVPTFDn/SH1Eo8ioSN7GkREh8OArC5KNoxzY4avHvutPDUV7230wBJfs42Yic6eQzYVRGfFK0MACwb1gCDdMPjIOFmct0Nbj3H5Dc07ixkrMbRL/8TSMzWUkA/2Rq2VZaEpAIODLywtGuioJELBWW9evMG/GGkYnk5mhdqqvaZzPmXONgqpAQeku9BOGx1rK1B9l7xR6x5p/9E1beSMTnkkz8HS4pAfSuUK5FX7acT4pjbgjbskjbOQtDEQzabcYIzvoZHXGhiwLjy1Dc21fz3WCIR3T5/2QcMYNlQFPqkEHXhD6pLgbWrz3KAW7s5P23qeOACqSVd6w+Yx7XfGm7ihLhrPUdhwnVkKvJln8qipvyWBjjOSq+noL25g+WHfm/K1rSuZdw1IODA6YedNcGkU9d5jhXxrF/m3MVa7s8TdeAB43Ah1xx51SVEpxP3/haAfUQXNOjVeCa9FpujA/jEnvReon36VkJG4SZrJGRk6Uhwzlkc4R5uL6lweyxhreeUZJLGgEu+A2Mv3hTtGfVJ4GeV5wSmMjs6FtjEpiq2msdPjG7L0dG8rxD2yp2PMEK71rLNuPzEQ3YVG4Qe5B+d7WFY9GkTl0SR9zG5l9shOWlmsTnc6p4T9E6daIpmm2mwAAAABJRU5ErkJggg==";
    hit.height = 420;
		hit.latitude = 52.10000000;
		hit.longitude = 21.20000000;
		hit.x = 34;
		hit.y =  360;
		hit.provider = "gps";
		hit.timestamp = 1519857468605;
		hit.width =  843;

    return hit;

  }
}