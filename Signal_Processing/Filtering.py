import soundfile as sf
import matplotlib.pyplot as plt
import numpy as np 

y , Fs = sf.read("Muffled_Noise_wav.wav")
Y = np.fft.fft(y)
mag = np.abs(Y)
freq = np.fft.fftfreq(len(Y), 1/Fs)
#print(freq)
plt.plot(freq,mag)
plt.grid(True)
plt.xlabel('f')
plt.ylabel('Y(f)')
plt.show()
print(Fs)
print(len(Y))

FFT_data = np.column_stack((freq, Y))
np.savetxt("FFT.csv", FFT_data, fmt = "%f", delimiter = ",")





