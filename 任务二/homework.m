% 参数设置
fs = 1000;          % 采样频率 (Hz)
t = 0:1/fs:5-1/fs;  % 时间向量 5 秒，2000 个采样点)

% 生成信号
sin_wave = sin(2*pi*10*t);         % 10 Hz 正弦波
square_wave = square(4*pi*2*t);   % 4 Hz 方波
step_signal = [zeros(1, fs), ones(1, fs),zeros(1, fs), ones(1, fs), zeros(1, fs)];  % 阶跃信号（2 秒，1 秒时跳变）
chirp_signal = chirp(t, 0, 5, 50);  % 5 秒内频率从 0 Hz 到 50 Hz

% 将信号存储在一个结构体中
signals = struct();
signals.sin_wave = sin_wave;
signals.square_wave = square_wave;
signals.step_signal = step_signal;
signals.chirp_signal = chirp_signal;

% 信号加法:将正弦波和方波相加
added_signal = sin_wave + square_wave;

% 信号乘法:正弦波和阶跃信号相乘
multiplied_signal = sin_wave .* step_signal;

% 信号卷积:计算正弦波和 Chirp 信号的卷积
convolved_signal = conv(sin_wave, chirp_signal, 'same');

% 绘制原始信号
figure;
subplot(4, 1, 1);
plot(t, sin_wave);
title('5 Hz 正弦波');
xlabel('时间 (秒)');
ylabel('幅值');

%subplot(4, 1, 2);
%plot(t, square_wave);
%title('4 Hz 方波');
%xlabel('时间 (秒)');
%ylabel('幅值');

subplot(4, 1, 3);
plot(t, step_signal);
title('阶跃信号');
xlabel('时间 (秒)');
ylabel('幅值');

subplot(4, 1, 4);
plot(t, chirp_signal);
title('Chirp 信号');
xlabel('时间 (秒)');
ylabel('幅值');

% 绘制运算后信号
figure;
subplot(3, 1, 1);
plot(t, added_signal);
title('正弦波 + 方波');
xlabel('时间 (秒)');
ylabel('幅值');

subplot(3, 1, 2);
plot(t, multiplied_signal);
title('正弦波 × 阶跃信号');
xlabel('时间 (秒)');
ylabel('幅值');

subplot(3, 1, 3);
plot(t, convolved_signal);
title('正弦波与 Chirp 信号的卷积');
xlabel('时间 (秒)');
ylabel('幅值');

% 时域波形分析
disp('=== 时域波形分析 ===');

% 分析原始信号
disp('1. 原始信号分析:');
analyze_signal(sin_wave, t, '正弦波');
analyze_signal(square_wave, t, '方波');
analyze_signal(step_signal, t, '阶跃信号');
analyze_signal(chirp_signal, t, 'Chirp 信号');

% 分析运算后信号
disp('2. 运算后信号分析:');
analyze_signal(added_signal, t, '正弦波 + 方波');
analyze_signal(multiplied_signal, t, '正弦波 × 阶跃信号');
analyze_signal(convolved_signal, t, '正弦波与 Chirp 信号的卷积');

% 时域波形分析函数
function analyze_signal(signal, t, signal_name)
    % 计算信号的基本统计特性
    signal_mean = mean(signal);          % 均值
    signal_max = max(signal);            % 最大值
    signal_min = min(signal);            % 最小值
    signal_pp = signal_max - signal_min; % 峰峰值
    signal_rms = rms(signal);            % 均方根值

    % 显示信号特性
    fprintf('  信号: %s\n', signal_name);
    fprintf('  均值: %.4f\n', signal_mean);
    fprintf('  最大值: %.4f\n', signal_max);
    fprintf('  最小值: %.4f\n', signal_min);
    fprintf('  峰峰值: %.4f\n', signal_pp);
    fprintf('  均方根值: %.4f\n', signal_rms);

    % 绘制信号
    figure;
    plot(t, signal);
    title([signal_name, ' 时域波形']);
    xlabel('时间 (秒)');
    ylabel('幅值');
end

