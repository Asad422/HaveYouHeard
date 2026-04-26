#Routing in current project

@RoutePage()
  class AuthPage extends StatelessWidget { ... }

  // Перейти на страницу
  context.router.push(GameRoute());

  // Заменить текущую (без кнопки назад)
  context.router.replace(GameRoute());

  // Очистить стек и перейти (например после логина)
  context.router.replaceAll([GameRoute()]);



<!-- 
  Чтобы добавить новый роут — создай страницу с @RoutePage(), добавь в routes список, и запусти:
  dart run build_runner build -->
