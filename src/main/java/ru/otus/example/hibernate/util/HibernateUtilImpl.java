package ru.otus.example.hibernate.util;

import org.hibernate.SessionFactory;
import ru.otus.example.hibernate.enums.SessionFactoryType;

import static ru.otus.example.hibernate.configurations.AnnotationBasedSessionFactory.getAnnotationBasedSessionFactory;
import static ru.otus.example.hibernate.configurations.JavaBasedSessionFactory.getJavaBasedSessionFactory;
import static ru.otus.example.hibernate.configurations.XmlBasedSessionFactory.getXmlBasedSessionFactory;

public class HibernateUtilImpl implements HibernateUtil {

	@Override
	public SessionFactory buildSessionFactory(SessionFactoryType type) {
		return switch (type) {
			case ANNOTATION_BASED -> getAnnotationBasedSessionFactory();
			case JAVA_BASED -> getJavaBasedSessionFactory();
			case XML_BASED -> getXmlBasedSessionFactory();
		};
	}

}