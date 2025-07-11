import 'package:flutter/material.dart';

class StudentDestinationView extends StatefulWidget {
  const StudentDestinationView({
    super.key,
    this.onConfirm,
    });

    final ValueChanged<String>? onConfirm;

  @override
  State<StudentDestinationView> createState() => _StudentDestinationViewState();
}

class _StudentDestinationViewState extends State<StudentDestinationView> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  /// Lista maestra de destinos (puedes reemplazarla por datos remotos)
  static const List<String> _allDestinations = [
    'UPC - San Miguel',
    'UPC - Monterrico',
    'UPC - San Isidro',
    'UNMSM - Ciudad Universitaria',
    'UNI - Independencia',
    'PUCP - San Miguel',
    'UPN - Lima Norte',
    'USMP - La Molina',
  ];

  List<String> _filtered = _allDestinations; // inicialmente todas

  @override
  void initState() {
    super.initState();

    // Filtrar en cada cambio de texto
    _controller.addListener(_filterList);
  }

  void _filterList() {
    final input = _controller.text.toLowerCase();
    setState(() {
      _filtered = _allDestinations
          .where((d) => d.toLowerCase().contains(input))
          .toList();
    });
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_filterList)
      ..dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    final dest = _controller.text.trim(); //guardando el valor
    if (dest.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Por favor ingresa o selecciona un destino.')));
      return;
    }
    // Devuelve el valor a quien lo invoque
    widget.onConfirm?.call(dest);
    Navigator.pop(context,dest);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Color(0xFF1286F2)),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[50],
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.black54),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          if (_filtered.isNotEmpty)
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _filtered.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: Colors.grey),
                itemBuilder: (_, i) {
                  final s = _filtered[i];
                  return ListTile(
                    leading: const Icon(Icons.school, color: Colors.indigo),
                    title: Text(s),
                    onTap: () {
                      _controller.text = s;
                      _focusNode.unfocus();
                    },
                  );
                },
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Sin coincidencias'),
            ),

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1824F7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: _handleConfirm,
                child: const Text(
                  'ir',
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}