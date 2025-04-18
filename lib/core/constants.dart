enum Constant{
  dev(environment:"http://localhost:8080/");
  const Constant({required this.environment});
  final String environment;

}