@SpringBootApplication
@EnableDiscoveryClient
@RestController
@RequestMapping("/products")
public class ProductApplication {
    public static void main(String[] args) {
        SpringApplication.run(ProductApplication.class, args);
    }

    @GetMapping("/{id}")
    public String getProduct(@PathVariable String id) {
        return "Product " + id + " (from port: " + env.getProperty("local.server.port") + ")";
    }

    @Autowired
    private Environment env;
}
