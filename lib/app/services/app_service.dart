import 'package:find_intern/ui/common/app_tops.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppService {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<String>> getCategories() async {
    List<String> categories = [];
    try {
      final result = await client.from('categories').select('name');
      for (var item in result) {
        categories.add(item['name']);
      }
      AppTops.categories.clear();
      AppTops.categories.addAll(categories);
      return categories;
    } catch (e) {
      return [];
    }
  }

  Future<void> getUserInfo() async {
    UserResponse user = await client.auth.getUser();
    AppTops.email = user.user?.email;
  }
}
