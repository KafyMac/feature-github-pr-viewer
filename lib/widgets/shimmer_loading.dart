import 'package:flutter/material.dart';

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({Key? key}) : super(key: key);

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _ShimmerBox(
                          width: 32,
                          height: 32,
                          borderRadius: 16,
                          animation: _animation,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ShimmerBox(
                                width: 100,
                                height: 14,
                                animation: _animation,
                              ),
                              const SizedBox(height: 4),
                              _ShimmerBox(
                                width: 80,
                                height: 12,
                                animation: _animation,
                              ),
                            ],
                          ),
                        ),
                        _ShimmerBox(
                          width: 50,
                          height: 24,
                          borderRadius: 12,
                          animation: _animation,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _ShimmerBox(
                      width: double.infinity,
                      height: 18,
                      animation: _animation,
                    ),
                    const SizedBox(height: 8),
                    _ShimmerBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 14,
                      animation: _animation,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Animation<double> animation;

  const _ShimmerBox({
    required this.width,
    required this.height,
    this.borderRadius = 4,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.grey[300]!, Colors.grey[100]!, Colors.grey[300]!],
          stops: [animation.value - 1, animation.value, animation.value + 1],
        ),
      ),
    );
  }
}
