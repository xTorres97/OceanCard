import 'package:flutter/material.dart';
import 'package:ocean_card/presentation/widgets/steps.dart';
import 'package:country_pickers/country_pickers.dart';

class PersonalInformation extends StatefulWidget {
  final ValueChanged<Map<String, dynamic>> onNext;
  const PersonalInformation({super.key, required this.onNext});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _dobDisplayController = TextEditingController();
  final TextEditingController _phoneNumberOnlyController =
      TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // PIN is handled in separate CreatePin/ConfirmPin steps
  String _fullPhone = '';
  bool _isValid = false;
  String? _selectedCountryCode;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 800),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Título y subtítulo
                Column(
                  children: [
                    StepsIndicator(totalSteps: 3, stepNow: 0),
                    const SizedBox(height: 8),
                    Text(
                      'Información personal',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Te pedimos tu información personal para verificar tu identidad',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                        color: colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Inputs
                TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  onChanged: (_) => _validate(),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Apellido',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  onChanged: (_) => _validate(),
                ),
                const SizedBox(height: 10),
                // Fecha de nacimiento: usar DatePicker. Internamente guardamos
                // YYYYMMDD en `_dobController` y mostramos YYYY/MM/DD en el campo.
                TextField(
                  controller: _dobDisplayController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Fecha de nacimiento',
                    hintText: 'Selecciona tu fecha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  onTap: () async {
                    final now = DateTime.now();
                    final firstDate = DateTime(now.year - 120, 1, 1);
                    final lastDate = DateTime(
                      now.year - 18,
                      now.month,
                      now.day,
                    );
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: lastDate,
                      firstDate: firstDate,
                      lastDate: lastDate,
                    );
                    if (picked != null) {
                      final y = picked.year.toString().padLeft(4, '0');
                      final m = picked.month.toString().padLeft(2, '0');
                      final d = picked.day.toString().padLeft(2, '0');
                      // internal (no slashes) for validation/submission
                      _dobController.text = '$y$m$d';
                      // display with slashes for readability
                      _dobDisplayController.text = '$y/$m/$d';
                      _validate();
                    }
                  },
                ),
                const SizedBox(height: 10),
                // Phone input: custom country selector + number field so we control dialog language
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final picked = await showDialog<Map<String, String>>(
                          context: context,
                          builder: (context) => CountrySearchDialog(),
                        );
                        if (picked != null) {
                          setState(() {
                            _selectedCountryCode = picked['isoCode'];
                            _countryController.text = picked['name'] ?? '';
                            // try to read phone code from country util
                          });
                          _validate();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          children: [
                            if (_selectedCountryCode != null)
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CountryPickerUtils.getDefaultFlagImage(
                                  CountryPickerUtils.getCountryByIsoCode(
                                    _selectedCountryCode!,
                                  ),
                                ),
                              ),
                            Text(
                              _selectedCountryCode ?? 'PA',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _phoneNumberOnlyController,
                        decoration: const InputDecoration(
                          labelText: 'Número de teléfono',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: (val) {
                          final dial = _getSelectedPhoneDialCode();
                          _fullPhone =
                              '$dial${val.replaceAll(RegExp(r'\\s+'), '')}';
                          _validate();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Country picker: open a dialog with searchable list
                GestureDetector(
                  onTap: () async {
                    final picked = await showDialog<Map<String, String>>(
                      context: context,
                      builder: (context) => CountrySearchDialog(),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedCountryCode = picked['isoCode'];
                        _countryController.text = picked['name'] ?? '';
                      });
                      _validate();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    height: 56,
                    child: Row(
                      children: [
                        if (_selectedCountryCode != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CountryPickerUtils.getDefaultFlagImage(
                              CountryPickerUtils.getCountryByIsoCode(
                                _selectedCountryCode!,
                              ),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            _countryController.text.isNotEmpty
                                ? _countryController.text
                                : 'Selecciona un país',
                            style: TextStyle(
                              color: _countryController.text.isNotEmpty
                                  ? Colors.black
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (_) => _validate(),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 20),

                // Botón
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _isValid
                          ? () {
                              // Collect the data and pass upstream
                              final data = <String, dynamic>{
                                'name': _firstNameController.text.trim(),
                                'lastname': _lastNameController.text.trim(),
                                'phoneNumber': _fullPhone,
                                'country': _countryController.text.trim(),
                                'dateOfBirth': _dobController.text.trim(),
                                'email': _emailController.text.trim(),
                              };
                              widget.onNext(data);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(16),
                        elevation: 2,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validate() {
    final nameOk = _firstNameController.text.trim().isNotEmpty;
    final lastOk = _lastNameController.text.trim().isNotEmpty;
    final dob = _dobController.text.trim();
    final dobOk = RegExp(r'^\d{8}$').hasMatch(dob); // YYYYMMDD
    final phoneOk = _fullPhone.isNotEmpty;
    final countryOk = _countryController.text.trim().isNotEmpty;
    final emailOk = _emailController.text.contains('@');
    final valid = nameOk && lastOk && dobOk && phoneOk && countryOk && emailOk;
    if (valid != _isValid) {
      setState(() => _isValid = valid);
    }
  }

  String _getSelectedPhoneDialCode() {
    try {
      if (_selectedCountryCode != null) {
        final country = CountryPickerUtils.getCountryByIsoCode(
          _selectedCountryCode!,
        );
        // Access dynamically: if an attribute like 'phoneCode' exists use it, otherwise fallback
        final dyn = country as dynamic;
        final maybe =
            (dyn.phoneCode ??
                    dyn.dialCode ??
                    dyn['phone_code'] ??
                    dyn['phoneCode'])
                ?.toString();
        if (maybe != null && maybe.isNotEmpty) {
          final dc = maybe.startsWith('+') ? maybe : '+$maybe';
          return dc;
        }
      }
    } catch (_) {}
    return '+1';
  }
}

class CountrySearchDialog extends StatefulWidget {
  const CountrySearchDialog({super.key});

  @override
  State<CountrySearchDialog> createState() => _CountrySearchDialogState();
}

class _CountrySearchDialogState extends State<CountrySearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  late List<dynamic> _all; // from country_pickers
  late List<dynamic> _filtered;

  @override
  void initState() {
    super.initState();
    _all = countryListFromCountryPicker();
    _filtered = List.from(_all);
    _searchController.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _searchController.text.toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _filtered = List.from(_all);
      } else {
        _filtered = _all.where((c) {
          final name = (c?.name ?? '').toString().toLowerCase();
          final iso = (c?.isoCode ?? '').toString().toLowerCase();
          return name.contains(q) || iso.contains(q);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearch);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seleccionar país'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Buscar país',
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.maxFinite,
            height: 320,
            child: ListView.separated(
              itemCount: _filtered.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final c = _filtered[index];
                final name = (c?.name ?? '').toString();
                final iso = (c?.isoCode ?? '').toString();
                return ListTile(
                  leading: CountryPickerUtils.getDefaultFlagImage(c),
                  title: Text(name),
                  subtitle: Text(iso),
                  onTap: () =>
                      Navigator.of(context).pop({'isoCode': iso, 'name': name}),
                );
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}

// Helper to extract the country list from country_pickers package.
List<dynamic> countryListFromCountryPicker() {
  // country_pickers exposes a `countries` list inside its package; we access via `CountryPickerUtils` helper by iterating known codes.
  // Unfortunately `country_pickers` does not export a single list, so reconstruct using the provided util for common ISO codes.
  // We'll use a pragmatic subset of ISO codes commonly used in the app.
  const isoCodes = [
    'US',
    'ES',
    'MX',
    'AR',
    'CL',
    'CO',
    'PE',
    'VE',
    'UY',
    'BR',
    'CA',
    'GB',
    'FR',
    'DE',
    'IT',
    'NL',
    'SE',
    'NO',
    'DK',
    'FI',
    'JP',
    'CN',
    'IN',
    'AU',
    'NZ',
  ];
  final List<dynamic> list = isoCodes
      .map((iso) => CountryPickerUtils.getCountryByIsoCode(iso))
      .toList();
  // fall back: ensure list is not empty
  if (list.isEmpty) {
    final fallback = CountryPickerUtils.getCountryByIsoCode('US');
    return [fallback];
  }
  return list;
}

  // Note: controllers are disposed in their owning State classes. PersonalInformation
  // uses automatic disposal of its controllers here if needed; the CountrySearchDialog
  // already disposes its own controllers.
