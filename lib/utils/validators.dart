import 'constants.dart';

class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите email';
    }
    
    if (!RegExp(AppConstants.emailPattern).hasMatch(value)) {
      return 'Введите корректный email';
    }
    
    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите пароль';
    }
    
    if (value.length < AppConstants.minPasswordLength) {
      return 'Пароль должен содержать минимум ${AppConstants.minPasswordLength} символов';
    }
    
    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Подтвердите пароль';
    }
    
    if (value != password) {
      return 'Пароли не совпадают';
    }
    
    return null;
  }

  // Username validation
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите имя';
    }
    
    if (value.length < AppConstants.minUsernameLength) {
      return 'Имя должно содержать минимум ${AppConstants.minUsernameLength} символа';
    }
    
    if (value.length > AppConstants.maxUsernameLength) {
      return 'Имя не должно превышать ${AppConstants.maxUsernameLength} символов';
    }
    
    return null;
  }

  // Post title validation
  static String? validatePostTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите название';
    }
    
    if (value.length > AppConstants.maxPostTitleLength) {
      return 'Название не должно превышать ${AppConstants.maxPostTitleLength} символов';
    }
    
    return null;
  }

  // Post description validation
  static String? validatePostDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите описание';
    }
    
    if (value.length > AppConstants.maxPostDescriptionLength) {
      return 'Описание не должно превышать ${AppConstants.maxPostDescriptionLength} символов';
    }
    
    return null;
  }

  // Recipe validation
  static String? validateRecipe(String? value) {
    if (value != null && value.length > AppConstants.maxRecipeLength) {
      return 'Рецепт не должен превышать ${AppConstants.maxRecipeLength} символов';
    }
    
    return null;
  }

  // Bio validation
  static String? validateBio(String? value) {
    if (value != null && value.length > AppConstants.maxBioLength) {
      return 'Описание не должно превышать ${AppConstants.maxBioLength} символов';
    }
    
    return null;
  }

  // Ingredient validation
  static String? validateIngredient(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите ингредиент';
    }
    
    if (value.length > 50) {
      return 'Ингредиент не должен превышать 50 символов';
    }
    
    return null;
  }

  // Tag validation
  static String? validateTag(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите тег';
    }
    
    if (value.length > 30) {
      return 'Тег не должен превышать 30 символов';
    }
    
    if (value.contains(' ')) {
      return 'Тег не должен содержать пробелы';
    }
    
    return null;
  }

  // Phone validation (optional)
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Phone is optional
    }
    
    // Simple phone validation for Russian numbers
    if (!RegExp(r'^\+?[78][\d\s\-\(\)]{10,}$').hasMatch(value)) {
      return 'Введите корректный номер телефона';
    }
    
    return null;
  }

  // URL validation
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null; // URL is optional
    }
    
    if (!RegExp(r'^https?:\/\/[\w\-]+(\.[\w\-]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$').hasMatch(value)) {
      return 'Введите корректный URL';
    }
    
    return null;
  }

  // Generic required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Поле "$fieldName" обязательно для заполнения';
    }
    
    return null;
  }

  // Length validation
  static String? validateLength(String? value, int minLength, int maxLength, String fieldName) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    if (value.length < minLength) {
      return '$fieldName должно содержать минимум $minLength символов';
    }
    
    if (value.length > maxLength) {
      return '$fieldName не должно превышать $maxLength символов';
    }
    
    return null;
  }

  // Number validation
  static String? validateNumber(String? value, {int? min, int? max}) {
    if (value == null || value.isEmpty) {
      return 'Введите число';
    }
    
    final number = int.tryParse(value);
    if (number == null) {
      return 'Введите корректное число';
    }
    
    if (min != null && number < min) {
      return 'Число должно быть не меньше $min';
    }
    
    if (max != null && number > max) {
      return 'Число должно быть не больше $max';
    }
    
    return null;
  }
}
