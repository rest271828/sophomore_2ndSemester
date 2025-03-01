fs = 16000;                                  % 采样频率（Hz）
nBits = 8;                                   % 采样位数（8位）
duration = 5;                                % 录音时长（秒）
n = duration * fs;                           % 总采样点数
t = (1:n) / fs;                              % 时间轴

% 提示用户开始录音
disp('Start speaking.');

% 创建录音对象，指定为双声道（2）
y = audiorecorder(fs, nBits, 2);

% 开始录制声音，录制时长为2秒
recordblocking(y, 5);

% 提示录音结束
disp('End of Recording.');

% 获取录音数据（返回的是一个二维数组，列对应两个通道）
myRecording = getaudiodata(y);

% 将录音数据保存为WAV文件
file_name = 'sound_stereo.wav';               % 文件名
audiowrite(file_name, myRecording, fs);      % 保存录音数据到文件

% 播放录音
disp('Playing the recorded audio...');
play(y);

% 等待播放完成后绘制波形图
pause(duration + 1);  % 确保音频播放完毕后再绘制图形

% 绘制录音信号的时域波形（绘制两个通道的波形）
figure(1);
subplot(2, 1, 1);                           % 绘制左通道（第一个通道）
plot(t, myRecording(:,1));                  % 左通道波形
xlabel('时间/s');
ylabel('幅度');
title('左通道录音信号时域波形');

subplot(2, 1, 2);                           % 绘制右通道（第二个通道）
plot(t, myRecording(:,2));                  % 右通道波形
xlabel('时间/s');
ylabel('幅度');
title('右通道录音信号时域波形');
