// ignore_for_file: always_put_control_body_on_new_line, prefer_final_locals

import 'dart:math';

import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:just_waveform/just_waveform.dart';

class AudioWaveform extends StatelessWidget {
  final Color waveColor;
  final double scale;
  final double strokeWidth;
  final double pixelsPerStep;
  final Waveform waveform;
  final Duration start;
  final Duration duration;
  final Duration progress;

  const AudioWaveform({
    required this.waveform,
    required this.start,
    required this.duration,
    required this.progress,
    this.waveColor = AppColors.wavecColor,
    this.scale = 5.0, //default 1.0
    this.strokeWidth = 5.0,
    this.pixelsPerStep = 8.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        painter: AudioWaveformPainter(
          progress: progress,
          waveColor: waveColor,
          waveform: waveform,
          start: start,
          duration: duration,
          scale: scale,
          strokeWidth: strokeWidth,
          pixelsPerStep: pixelsPerStep,
        ),
      ),
    );
  }
}

class AudioWaveformPainter extends CustomPainter {
  final double scale;
  final double strokeWidth;
  final double pixelsPerStep;
  final Paint wavePaint;
  final Paint activeWavePaint;
  final Waveform waveform;
  final Duration start;
  final Duration duration;
  final Duration progress;

  AudioWaveformPainter({
    required this.waveform,
    required this.start,
    required this.duration,
    required this.progress,
    Color waveColor = AppColors.wavecColor,
    Color activeColor = Colors.white,
    this.scale = 1.0,
    this.strokeWidth = 5.0,
    this.pixelsPerStep = 8.0,
  })  : wavePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..color = waveColor,
        activeWavePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..color = activeColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (duration == Duration.zero) return;

    double width = size.width;
    double height = size.height;

    final waveformPixelsPerWindow = waveform.positionToPixel(duration).toInt();
    final waveformPixelsPerDevicePixel = waveformPixelsPerWindow / width;
    final waveformPixelsPerStep = waveformPixelsPerDevicePixel * pixelsPerStep;
    final sampleOffset = waveform.positionToPixel(start);
    final sampleStart = -sampleOffset % waveformPixelsPerStep;
    for (var i = sampleStart.toDouble();
        i <= waveformPixelsPerWindow + 1.0;
        i += waveformPixelsPerStep) {
      final sampleIdx = (sampleOffset + i).toInt();
      final x = i / waveformPixelsPerDevicePixel;
      final minY = normalise(waveform.getPixelMin(sampleIdx), height);
      final maxY = normalise(waveform.getPixelMax(sampleIdx), height);
      canvas.drawLine(
        Offset(x + strokeWidth / 2, max(strokeWidth * 0.75, minY)),
        Offset(x + strokeWidth / 2, min(height - strokeWidth * 0.75, maxY)),
        wavePaint,
      );
    }

    final activewaveformPixelsPerWindow =
        waveform.positionToPixel(progress).toInt();
    final activewaveformPixelsPerDevicePixel = waveformPixelsPerWindow / width;
    final activewaveformPixelsPerStep =
        waveformPixelsPerDevicePixel * pixelsPerStep;
    final activesampleOffset = waveform.positionToPixel(start);
    final activesampleStart = -sampleOffset % waveformPixelsPerStep;
    if (progress.inSeconds > 0)
      for (var i = activesampleStart.toDouble();
          i <= activewaveformPixelsPerWindow + 1.0;
          i += activewaveformPixelsPerStep) {
        final sampleIdx = (activesampleOffset + i).toInt();
        final x = i / activewaveformPixelsPerDevicePixel;
        final minY = normalise(waveform.getPixelMin(sampleIdx), height);
        final maxY = normalise(waveform.getPixelMax(sampleIdx), height);
        canvas.drawLine(
          Offset(x + strokeWidth / 2, max(strokeWidth * 0.75, minY)),
          Offset(x + strokeWidth / 2, min(height - strokeWidth * 0.75, maxY)),
          activeWavePaint,
        );
      }
  }

  @override
  bool shouldRepaint(covariant AudioWaveformPainter oldDelegate) {
    return true;
  }

  double normalise(int s, double height) {
    if (waveform.flags == 0) {
      final y = 32768 + (scale * s).clamp(-32768.0, 32767.0).toDouble();

      return height - 1 - y * height / 65536;
    } else {
      final y = 128 + (scale * s).clamp(-128.0, 127.0).toDouble();

      return height - 1 - y * height / 256;
    }
  }
}
