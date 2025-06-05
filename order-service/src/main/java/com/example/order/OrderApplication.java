@SpringBootApplication
@EnableDiscoveryClient
@RestController
@RequestMapping("/orders")
public class OrderApplication {
    public static void main(String[] args) {
        SpringApplication.run(OrderApplication.class, args);
    }

    @PostMapping
    public String createOrder() {
        return "Order created (from port: " + env.getProperty("local.server.port") + ")";
    }

    @Autowired
    private Environment env;
}
