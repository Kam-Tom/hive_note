class ResourceAlreadyExistsException implements Exception {
  final String message;

  ResourceAlreadyExistsException([this.message = 'Resource already exists']);

  @override
  String toString() => 'ResourceAlreadyExistsException: $message';
}
