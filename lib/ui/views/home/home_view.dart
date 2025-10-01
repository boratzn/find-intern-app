import 'package:find_intern/app/app.router.dart';
import 'package:find_intern/ui/common/app_tops.dart';
import 'package:find_intern/ui/views/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      key: viewModel.scaffoldKey,
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(viewModel),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(),
            _buildSearchSection(), //Buraya bakılacak
            _buildStatsSection(), //Buraya bakılacak
            CategoriesSectionWidget(
              viewModel: viewModel,
            ),
            _buildFeaturedInternshipsSection(viewModel),
            _buildRecentApplicationsSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  @override
  onViewModelReady(viewModel) => viewModel.init();

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  AppBar _buildAppBar(HomeViewModel viewModel) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.menu, color: Colors.white, size: 20),
        ),
        onPressed: () => viewModel.scaffoldKey.currentState?.openDrawer(),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .1),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                const Icon(Icons.notifications_outlined,
                    color: Color(0xFF667eea), size: 20),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {},
        ),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white.withValues(alpha: .2),
                    child: const Icon(Icons.person, size: 30, color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  const Text(
                    'Ahmet Yılmaz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'ahmet@email.com',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.home, 'Ana Sayfa', () {}),
            _buildDrawerItem(Icons.search, 'Staj Ara', () {}),
            _buildDrawerItem(Icons.bookmark, 'Kaydedilenler', () {}),
            _buildDrawerItem(Icons.assignment, 'Başvurularım', () {}),
            _buildDrawerItem(Icons.person, 'Profilim', () {}),
            _buildDrawerItem(Icons.settings, 'Ayarlar', () {}),
            Divider(color: Colors.white.withOpacity(0.3)),
            _buildDrawerItem(Icons.help, 'Yardım', () {}),
            _buildDrawerItem(Icons.logout, 'Çıkış Yap', () {
              NavigationService().replaceWithLoginView();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white.withOpacity(0.8)),
      title: Text(
        title,
        style: TextStyle(color: Colors.white.withOpacity(0.8)),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Merhaba, ${AppTops.email} 👋',
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.clip,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Bugün hangi stajı keşfedelim?',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF718096),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF667eea).withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Staj ara... (ör: Flutter Developer)',
                prefixIcon: Icon(Icons.search, color: Color(0xFF667eea)),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text('İstanbul', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.category, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text('Teknoloji', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(child: _buildStatCard('12', 'Başvuru', Color(0xFF4285F4))),
          SizedBox(width: 16),
          Expanded(child: _buildStatCard('3', 'Mülakat', Color(0xFF34A853))),
          SizedBox(width: 16),
          Expanded(child: _buildStatCard('1', 'Teklif', Color(0xFFFF6B6B))),
        ],
      ),
    );
  }

  Widget _buildStatCard(String number, String label, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF718096),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedInternshipsSection(HomeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Öne Çıkan Stajlar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Tümünü Gör'),
              ),
            ],
          ),
        ),
        Container(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 24),
            itemCount: viewModel.featuredInternships.length,
            itemBuilder: (context, index) {
              return _buildInternshipCard(viewModel.featuredInternships[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInternshipCard(Map<String, dynamic> internship) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        internship['color'],
                        internship['color'].withOpacity(0.7)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      Icon(internship['logo'], color: Colors.white, size: 24),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        internship['company'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF718096),
                        ),
                      ),
                      Text(
                        internship['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.bookmark_border, color: Color(0xFF718096)),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Color(0xFF718096)),
                SizedBox(width: 4),
                Text(internship['location'],
                    style: TextStyle(color: Color(0xFF718096))),
                SizedBox(width: 16),
                Icon(Icons.schedule, size: 16, color: Color(0xFF718096)),
                SizedBox(width: 4),
                Text(internship['duration'],
                    style: TextStyle(color: Color(0xFF718096))),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: internship['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    internship['type'],
                    style: TextStyle(
                      color: internship['color'],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  internship['salary'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: internship['color'],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: internship['color'],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  ),
                  child: Text('Başvur', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentApplicationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Son Başvurularım',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Tümünü Gör'),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildApplicationItem('Backend Developer', 'TechStart',
                  'Değerlendirmede', Color(0xFFFF9500)),
              Divider(height: 1),
              _buildApplicationItem('Product Manager', 'InnovateCorp',
                  'Mülakat', Color(0xFF34C759)),
              Divider(height: 1),
              _buildApplicationItem(
                  'Data Analyst', 'DataPro', 'Reddedildi', Color(0xFFFF3B30)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildApplicationItem(
      String title, String company, String status, Color statusColor) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.work_outline, color: statusColor, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
                Text(
                  company,
                  style: TextStyle(
                    color: Color(0xFF718096),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: Color(0xFF667eea),
      icon: Icon(Icons.add, color: Colors.white),
      label: Text('Yeni Staj', style: TextStyle(color: Colors.white)),
    );
  }
}

class CategoriesSectionWidget extends StatelessWidget {
  const CategoriesSectionWidget({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return viewModel.categories.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Kategoriler',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Tümünü Gör'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: viewModel.categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 12),
                      child: Chip(
                        label: Text(
                          viewModel.categories[index],
                          style: TextStyle(
                            color:
                                index == 0 ? Colors.white : Color(0xFF667eea),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        backgroundColor:
                            index == 0 ? Color(0xFF667eea) : Colors.white,
                        side: BorderSide(color: Color(0xFF667eea)),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
