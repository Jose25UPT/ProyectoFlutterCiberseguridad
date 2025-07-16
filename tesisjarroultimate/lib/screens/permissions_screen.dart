import 'package:flutter/material.dart';
import 'package:tesisjarroultimate/db/permisos_database.dart';

class PermissionsDatabaseScreen extends StatefulWidget {
  const PermissionsDatabaseScreen({super.key});

  @override
  State<PermissionsDatabaseScreen> createState() => _PermissionsDatabaseScreenState();
}

class _PermissionsDatabaseScreenState extends State<PermissionsDatabaseScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredPermissions = [];
  String _selectedCategory = 'Todos';

  final Map<String, IconData> _categoryIcons = {
    'Ubicación': Icons.location_on,
    'Cámara': Icons.camera_alt,
    'Micrófono': Icons.mic,
    'Contactos': Icons.contacts,
    'Calendario': Icons.calendar_today,
    'Llamadas': Icons.call,
    'Mensajes': Icons.message,
    'Red': Icons.network_wifi,
    'Bluetooth': Icons.bluetooth,
    'NFC': Icons.nfc,
    'Seguridad': Icons.security,
    'Almacenamiento': Icons.storage,
    'Multimedia': Icons.photo_library,
    'Sistema': Icons.settings,
    'Accesibilidad': Icons.accessibility,
    'Notificaciones': Icons.notifications,
    'Teléfono': Icons.phone,
    'Audio': Icons.audiotrack,
    'Todos': Icons.apps,
  };

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterPermissions);
    _filteredPermissions = DatabaseHelper.getAllPermissions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPermissions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPermissions = DatabaseHelper.getAllPermissions().where((perm) {
        final name = perm['nombre']?.toString().toLowerCase() ?? 
                     perm['permiso']?.toString().toLowerCase() ?? '';
        final desc = perm['descripcion']?.toString().toLowerCase() ?? '';
        final category = perm['categoria']?.toString().toLowerCase() ?? '';
        final matchesSearch = name.contains(query) || desc.contains(query);
        final matchesCategory = _selectedCategory == 'Todos' || 
                              perm['categoria'] == _selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  Widget _buildCategoryChips() {
    final categories = ['Todos', ..._categoryIcons.keys.where((k) => k != 'Todos')];
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: FilterChip(
              label: Text(category),
              avatar: Icon(_categoryIcons[category], size: 20),
              selected: _selectedCategory == category,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = selected ? category : 'Todos';
                  _filterPermissions();
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Base de Datos de Permisos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PermissionsSearchDelegate(permissions: _filteredPermissions),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar permisos...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
              ),
            ),
          ),
          _buildCategoryChips(),
          Expanded(
            child: _filteredPermissions.isEmpty
                ? const Center(child: Text('No se encontraron permisos'))
                : ListView.builder(
                    itemCount: _filteredPermissions.length,
                    itemBuilder: (context, index) {
                      final permiso = _filteredPermissions[index];
                      return _PermissionCard(
                        permission: permiso,
                        categoryIcons: _categoryIcons,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _PermissionCard extends StatelessWidget {
  final Map<String, dynamic> permission;
  final Map<String, IconData> categoryIcons;

  const _PermissionCard({
    required this.permission,
    required this.categoryIcons,
  });

  @override
  Widget build(BuildContext context) {
    final categoria = permission['categoria'] ?? 'Sistema';
    final icon = categoryIcons[categoria] ?? Icons.lock;
    final color = _getCategoryColor(categoria);
    final nombre = permission['nombre'] ?? permission['permiso'] ?? 'Sin nombre';
    final clave = permission['clave_sistema'] ?? permission['constante'] ?? 'Sin clave';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () {
          _showPermissionDetails(context, permission);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nombre,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          categoria,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    label: const Text(
                      'Android',
                      style: TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.grey[200],
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                permission['descripcion'] ?? 'Sin descripción',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              SelectableText(
                clave,
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.blue[700],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    final colors = {
      'Ubicación': Colors.green,
      'Cámara': Colors.blue,
      'Micrófono': Colors.purple,
      'Contactos': Colors.orange,
      'Calendario': Colors.red,
      'Llamadas': Colors.teal,
      'Mensajes': Colors.indigo,
      'Red': Colors.cyan,
      'Bluetooth': Colors.blueAccent,
      'NFC': Colors.deepPurple,
      'Seguridad': Colors.amber,
      'Almacenamiento': Colors.brown,
      'Multimedia': Colors.pink,
      'Sistema': Colors.grey,
      'Accesibilidad': Colors.lightBlue,
      'Notificaciones': Colors.deepOrange,
      'Teléfono': Colors.lightGreen,
      'Audio': Colors.deepPurpleAccent,
    };
    return colors[category] ?? Colors.grey;
  }

  void _showPermissionDetails(BuildContext context, Map<String, dynamic> permission) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(permission['nombre'] ?? permission['permiso'] ?? 'Permiso'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                permission['descripcion'] ?? 'Sin descripción',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                'Categoría: ${permission['categoria']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SelectableText(
                permission['clave_sistema'] ?? permission['constante'] ?? '',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

class PermissionsSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> permissions;

  PermissionsSearchDelegate({required this.permissions});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final results = permissions.where((perm) {
      final name = perm['nombre']?.toString().toLowerCase() ?? 
                   perm['permiso']?.toString().toLowerCase() ?? '';
      final desc = perm['descripcion']?.toString().toLowerCase() ?? '';
      return name.contains(query.toLowerCase()) || 
             desc.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final permiso = results[index];
        return ListTile(
          title: Text(permiso['nombre'] ?? permiso['permiso'] ?? ''),
          subtitle: Text(permiso['descripcion'] ?? ''),
          onTap: () {
            close(context, null);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text(permiso['nombre'] ?? permiso['permiso'] ?? ''),
                  ),
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          permiso['descripcion'] ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Categoría: ${permiso['categoria']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          permiso['clave_sistema'] ?? permiso['constante'] ?? '',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}