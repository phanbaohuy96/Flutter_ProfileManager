class AccountGroup {
  final String name;
  final String imageAsset;
  final List<Account> accounts;

  AccountGroup(this.name, {this.imageAsset = '', this.accounts = const []});

  bool hasImageAsset() => imageAsset != '';
}

class Account {
  final String userName;
  final String password;
  final String avatarAsset;

  const Account(this.userName, this.password, {this.avatarAsset = ''});
}

final AccountGroup fbAccGroup = AccountGroup('Facebook',
    imageAsset: 'assets/images/account_icon/facebook_account_icon.png',
    accounts: [
      const Account('pbh96', 'hoilamgi'),
      const Account('baohuy.phan.9', 'hoilamgi'),
      const Account('pbh96', 'hoilamgi'),
      const Account('baohuy.phan.9', 'hoilamgi')
    ]);

final AccountGroup ggAccGroup = AccountGroup('Google',
    imageAsset: 'assets/images/account_icon/google_account_icon.png',
    accounts: [
      const Account('baohuy.phan1996@gmail.com', 'hoilamgi'),
      const Account('baohuy.phan96@gmail.com', 'hoilamgi'),
      const Account('baohuy.phan1996@gmail.com', 'hoilamgi'),
      const Account('baohuy.phan96@gmail.com', 'hoilamgi'),
    ]);

final AccountGroup pubgAccGroup = AccountGroup('PUBG',
    imageAsset: 'assets/images/account_icon/pubg_account_icon.png',
    accounts: [
      const Account('phanbaohuy96', 'hoilamgi'),
      const Account('lamgico2acc', 'hoilamgi'),
    ]);

final List<AccountGroup> accountGroups = [fbAccGroup, ggAccGroup, pubgAccGroup];
