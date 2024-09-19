package com.ecom.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.function.BiConsumer;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ecom.model.Cart;
import com.ecom.model.Category;
import com.ecom.model.OrderRequest;
import com.ecom.model.Product;
import com.ecom.model.ProductOrder;
import com.ecom.model.UserDtls;
import com.ecom.service.CartService;
import com.ecom.service.CategoryService;
import com.ecom.service.OrderService;
import com.ecom.service.ProductService;
import com.ecom.service.UserService;
import com.ecom.util.CommonUtil;
import com.ecom.util.OrderStatus;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private CartService cartService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private CommonUtil commonUtil;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private ProductService productService;

    @GetMapping("/")
    public String home() {
        return "user/home";
    }

    @ModelAttribute
    public void getUserDetails(Principal p, Model m) {
        if (p != null) {
            String email = p.getName();
            UserDtls userDtls = userService.getUserByEmail(email);
            m.addAttribute("user", userDtls);
            Integer countCart = cartService.getCountCart(userDtls.getId());
            m.addAttribute("countCart", countCart);
        }

        List<Category> allActiveCategory = categoryService.getAllActiveCategory();
        m.addAttribute("categories", allActiveCategory);
    }

    @GetMapping("/addCart")
    public String addToCart(@RequestParam Integer pid, @RequestParam Integer quantity, Principal p, RedirectAttributes redirectAttributes) {
        UserDtls user = getLoggedInUserDetails(p);
        Cart saveCart = cartService.saveCart(pid, user.getId(), quantity);
        if (ObjectUtils.isEmpty(saveCart)) {
            redirectAttributes.addFlashAttribute("errorMsg", "Product added to cart failed");
        } else {
            redirectAttributes.addFlashAttribute("succMsg", "Product added to cart");
        }
        return "redirect:/product/" + pid;
    }

    @GetMapping("/cart")
    public String loadCartPage(Principal p, Model m) {
        UserDtls user = getLoggedInUserDetails(p);
        List<Cart> carts = cartService.getCartsByUser(user.getId());
        m.addAttribute("carts", carts);
        if (!carts.isEmpty()) {
            Double totalOrderPrice = carts.get(carts.size() - 1).getTotalOrderPrice();
            m.addAttribute("totalOrderPrice", totalOrderPrice);
        }
        return "user/cart";
    }

    @GetMapping("/cartQuantityUpdate")
    public String updateCartQuantity(@RequestParam String sy, @RequestParam Integer cid, RedirectAttributes redirectAttributes) {
        cartService.updateQuantity(sy, cid);
        return "redirect:/user/cart";
    }

    @PostMapping("/updateCart")
    public String updateCart(@RequestParam Map<String, String> params, Principal principal, RedirectAttributes redirectAttributes) {
        String userId = principal.getName();
        
        // Process each entry in the params map
        for (Map.Entry<String, String> entry : params.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();

            if (key.startsWith("quantity[")) {
                try {
                    // Extract cart ID
                    String cartIdStr = key.substring(10, key.length() - 1);
                    int cartId = Integer.parseInt(cartIdStr);

                    // Validate and parse quantity
                    if (value != null && !value.isEmpty()) {
                        int quantity = Integer.parseInt(value);
                        if (quantity > 0) {
                            cartService.updateQuantity(cartId, quantity);
                        } else {
                            redirectAttributes.addFlashAttribute("errorMsg", "Quantity must be greater than zero");
                            return "redirect:/user/cart";
                        }
                    } else {
                        redirectAttributes.addFlashAttribute("errorMsg", "Quantity value is missing");
                        return "redirect:/user/cart";
                    }
                } catch (NumberFormatException e) {
                    // Handle parse error
                    redirectAttributes.addFlashAttribute("errorMsg", "Invalid cart ID or quantity value");
                    return "redirect:/user/cart";
                }
            } else if (key.startsWith("remove[")) {
                try {
                    // Extract cart ID for removal
                    String cartIdStr = key.substring(7, key.length() - 1);
                    int cartId = Integer.parseInt(cartIdStr);
                    cartService.removeFromCart(cartId);
                } catch (NumberFormatException e) {
                    // Handle parse error
                    redirectAttributes.addFlashAttribute("errorMsg", "Invalid cart ID for removal");
                    return "redirect:/user/cart";
                }
            }
        }

        redirectAttributes.addFlashAttribute("succMsg", "Cart updated successfully");
        return "redirect:/user/cart";
    }




    private UserDtls getLoggedInUserDetails(Principal p) {
        String email = p.getName();
        return userService.getUserByEmail(email);
    }

    @GetMapping("/orders")
    public String orderPage(Principal p, Model m) {
        UserDtls user = getLoggedInUserDetails(p);
        List<Cart> carts = cartService.getCartsByUser(user.getId());
        m.addAttribute("carts", carts);
        if (!carts.isEmpty()) {
            Double orderPrice = carts.get(carts.size() - 1).getTotalOrderPrice();
            Double totalOrderPrice = orderPrice + 250 + 100;
            m.addAttribute("orderPrice", orderPrice);
            m.addAttribute("totalOrderPrice", totalOrderPrice);
        }
        return "user/order";
    }

    @GetMapping("/orderNow")
    public String orderNow(@RequestParam Integer pid, Principal p, Model m, RedirectAttributes redirectAttributes) {
        if (p == null) {
            return "redirect:/signin";
        }

        Product product = productService.getProductById(pid);

        if (product == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "Invalid product");
            return "redirect:/product/" + pid;
        }

        double deliveryFee = 250;
        double tax = 100;
        double totalPrice = product.getDiscountPrice();
        double totalOrderPrice = totalPrice + deliveryFee + tax;

        m.addAttribute("orderPrice", totalPrice);
        m.addAttribute("totalOrderPrice", totalOrderPrice);
        m.addAttribute("product", product);

        return "user/order";
    }

    @PostMapping("/save-order")
    public String saveOrder(@ModelAttribute OrderRequest request, Principal p, RedirectAttributes redirectAttributes) throws Exception {
        UserDtls user = getLoggedInUserDetails(p);
        orderService.saveOrder(user.getId(), request);
        return "redirect:/user/success";
    }

    @GetMapping("/success")
    public String loadSuccess() {
        return "user/success";
    }

    @GetMapping("/user-orders")
    public String myOrder(Model m, Principal p) {
        UserDtls loginUser = getLoggedInUserDetails(p);
        List<ProductOrder> orders = orderService.getOrdersByUser(loginUser.getId());
        m.addAttribute("orders", orders);
        return "user/my_orders";
    }

    @GetMapping("/update-status")
    public String updateOrderStatus(@RequestParam Integer id, @RequestParam Integer st, RedirectAttributes redirectAttributes) {
        OrderStatus status = OrderStatus.fromId(st);
        if (status != null) {
            ProductOrder updateOrder = orderService.updateOrderStatus(id, status.getName());
            try {
                commonUtil.sendMailForProductOrder(updateOrder, status.getName());
            } catch (Exception e) {
                e.printStackTrace();
            }
            redirectAttributes.addFlashAttribute("succMsg", "Status Updated");
        } else {
            redirectAttributes.addFlashAttribute("errorMsg", "Status not updated");
        }
        return "redirect:/user/user-orders";
    }

    @GetMapping("/profile")
    public String profile() {
        return "user/profile";
    }

    @PostMapping("/update-profile")
    public String updateProfile(@ModelAttribute UserDtls user, @RequestParam MultipartFile img, RedirectAttributes redirectAttributes) {
        UserDtls updateUserProfile = userService.updateUserProfile(user, img);
        if (ObjectUtils.isEmpty(updateUserProfile)) {
            redirectAttributes.addFlashAttribute("errorMsg", "Profile not updated");
        } else {
            redirectAttributes.addFlashAttribute("succMsg", "Profile Updated");
        }
        return "redirect:/user/profile";
    }

    @PostMapping("/change-password")
    public String changePassword(@RequestParam String newPassword, @RequestParam String currentPassword, Principal p, RedirectAttributes redirectAttributes) {
        UserDtls loggedInUserDetails = getLoggedInUserDetails(p);
        if (passwordEncoder.matches(currentPassword, loggedInUserDetails.getPassword())) {
            String encodedPassword = passwordEncoder.encode(newPassword);
            loggedInUserDetails.setPassword(encodedPassword);
            UserDtls updateUser = userService.updateUser(loggedInUserDetails);
            if (ObjectUtils.isEmpty(updateUser)) {
                redirectAttributes.addFlashAttribute("errorMsg", "Password not updated! Error on server");
            } else {
                redirectAttributes.addFlashAttribute("succMsg", "Password Updated successfully");
            }
        } else {
            redirectAttributes.addFlashAttribute("errorMsg", "Current Password incorrect");
        }
        return "redirect:/user/profile";
    }
}
