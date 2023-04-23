#[derive(Debug)]
enum Gender {
  Unspecified = 0,
  Female = 1,
  Male = 2,
}

#[derive(Debug, Copy, Clone)]
struct UserId(u64);

// 话题编号
#[derive(Debug, Copy, Clone)]
struct TopicId(u64);

#[derive(Debug)]
struct User {
  id: UserId,
  name: String,
  gender: Gender,
}

// 话题
#[derive(Debug)]
struct Topic {
  id: TopicId,
  name: String,
  owner: UserId,
}

// 定义聊天室中可能发生的事件
#[derive(Debug)]
enum Event {
  Join((UserId, TopicId)), // 加入
  Leave((UserId, TopicId)), // 离开
  Message((UserId, TopicId, String)), // 发消息
}

fn main() {
    let alice = User {
        id: UserId(1),
        name: "Alice".into(),
        gender: Gender::Female
    };

    let bob = User {
        id: UserId(2),
        name: "Bob".into(),
        gender: Gender::Male
    };
    
    let topic = Topic {
        id: TopicId(1),
        name: "rust".into(),
        owner: UserId(1)
    };

    let event1 = Event::Join((alice.id, topic.id));
    let event2 = Event::Join((bob.id, topic.id));
    let event3 = Event::Message((alice.id, topic.id, "Hello world!".into()));
    
    println!("event1: {:?}, event2: {:?}, event3: {:?}", event1, event2, event3);


    // 打印命令行参数
    for arg in std::env::args() {
        println!("{}", arg);
    }
}