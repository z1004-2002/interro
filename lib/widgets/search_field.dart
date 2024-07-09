import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';

class SearchField extends StatefulWidget {
  final String? hintText;
  final TextEditingController searchController;
  final Function()? onPressed;

  const SearchField({
    super.key,
    required this.searchController,
    this.onPressed,
    this.hintText,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    // Écouter les changements dans le texte du contrôleur
    widget.searchController.addListener(_updateClearButtonVisibility);
  }

  @override
  void dispose() {
    // Arrêter d'écouter les changements lorsque le widget est supprimé
    widget.searchController.removeListener(_updateClearButtonVisibility);
    super.dispose();
  }

  /// Mettre à jour la visibilité du bouton de suppression
  void _updateClearButtonVisibility() {
    setState(() {
      _showClearButton = widget.searchController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.searchController,
            decoration: InputDecoration(
              hintText: widget.hintText ?? 'Recherche',
              hintStyle: const TextStyle(
                color: greyColor,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onChanged: (_) {
              _updateClearButtonVisibility();
            },
          ),
        ),
        if (_showClearButton)
          IconButton(
            icon: const Icon(Icons.clear),
            color: greyColor,
            onPressed: () {
              widget.searchController.clear();
              _updateClearButtonVisibility();
            },
          ),
      ],
    );
  }
}
