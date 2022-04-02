package main

import (
	"github.com/gin-gonic/gin"
	"github.com/sumitroajiprabowo/gin-gorm-jwt-mysql/config"
	"github.com/sumitroajiprabowo/gin-gorm-jwt-mysql/controllers"
	"github.com/sumitroajiprabowo/gin-gorm-jwt-mysql/middleware"
	"github.com/sumitroajiprabowo/gin-gorm-jwt-mysql/repository"
	"github.com/sumitroajiprabowo/gin-gorm-jwt-mysql/services"
)

var (
	db             = config.SetupDatabase()
	userRepository = repository.NewUserRepository(db)
	bookRepository = repository.NewBookRepository(db)
	jwtService     = services.NewJWTService()
	userService    = services.NewUserService(userRepository)
	bookService    = services.NewBookService(bookRepository)
	authService    = services.NewAuthService(userRepository)
	authController = controllers.NewAuthController(authService, jwtService)
	userController = controllers.NewUserController(userService, jwtService)
	bookController = controllers.NewBookController(bookService, jwtService)
)

func main() {
	defer config.CloseDatabaseConnection(db)
	r := gin.Default()

	authRoutes := r.Group("/api/auth")
	{
		authRoutes.POST("/login", authController.Login)
		authRoutes.POST("/register", authController.Register)
	}

	userRoutes := r.Group("/api/user", middleware.AuthorizeJWT(jwtService))
	{
		userRoutes.GET("/profile", userController.GetUser)
		userRoutes.PUT("/profile", userController.UpdateUser)
	}

	bookRoutes := r.Group("api/books", middleware.AuthorizeJWT(jwtService))
	{
		bookRoutes.GET("/", bookController.GetAllMyBook)
		bookRoutes.GET("/:id", bookController.GetByID)
		bookRoutes.POST("/", bookController.CreateMyBook)
		bookRoutes.PUT("/:id", bookController.UpdateMyBook)
		bookRoutes.DELETE("/:id", bookController.DeleteMyBook)
	}

	publicBookRoute := r.Group("/api/public/books")
	{
		publicBookRoute.GET("/", bookController.GetAll)
		publicBookRoute.GET("/:id", bookController.GetByID)
	}

	r.Run(":8080")

}
